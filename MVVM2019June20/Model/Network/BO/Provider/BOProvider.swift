//
//  BOProvider.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Moya
import Result
import RxSwift
import RxCocoa

extension BO {
    public class Provider : MoyaProvider<BO.UntypedBaseTarget> {
        static let shared = Provider()
        
        public override init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
                             requestClosure: @escaping MoyaProvider<Target>.RequestClosure = Provider.defaultRequestMapping,
                             stubClosure: @escaping MoyaProvider<Target>.StubClosure = MoyaProvider.neverStub,
                             callbackQueue: DispatchQueue? = nil,
                             manager: Manager = MoyaProvider<Target>.defaultAlamofireManager(),
                             plugins: [PluginType] = [MoyaLoggerPlugin()],
                             trackInflights: Bool = false) {
            super.init(endpointClosure: endpointClosure,
                       requestClosure: requestClosure,
                       stubClosure: stubClosure,
                       callbackQueue: callbackQueue,
                       manager: manager,
                       plugins: plugins,
                       trackInflights: trackInflights)
        }
        
        func typedRequest<I, O>(_ target: BO.BaseTarget<I, O>,
                                callbackQueue: DispatchQueue? = .none,
                                progress: ProgressBlock? = .none,
                                completion: @escaping ((_ result: Result<O, MoyaError>) -> ())) -> Cancellable where O: Decodable {
            
            func validateResponseError(_ response: Moya.Response) -> MoyaError? {
                do {
                    let errorResponse = try response.map(BO.BaseResponse.self)
                    if errorResponse.errorCode.isNilOrEmpty == false {
                        let error = MoyaError.underlying(BO.Error.response(response: errorResponse), response)
                        return error
                    }
                    return nil
                } catch {
                    print("\(error)")
                    return nil
                }
            }
            
            return self.request(target as BO.UntypedBaseTarget,
                                callbackQueue: callbackQueue,
                                progress: progress,
                                completion: { result -> () in
                                    switch result {
                                    case .success(let response):
                                        if let error = validateResponseError(response) {
                                            let result: Result<O, MoyaError> = .failure(error)
                                            completion(result)
                                            return
                                        }
                                        do {
                                            let object = try response.map(O.self)
                                            let result: Result<O, MoyaError> = .success(object)
                                            completion(result)
                                        } catch {
                                            let error: MoyaError = error as! MoyaError
                                            let result: Result<O, MoyaError> = .failure(error)
                                            completion(result)
                                        }
                                        break
                                    case .failure(let error):
                                        let result: Result<O, MoyaError> = .failure(error)
                                        completion(result)
                                    }
                                    
                                    
            })
        }
    }
}

extension BO.BaseTarget where O : Codable {
    func request(provider: BO.Provider? = nil) -> Observable<O> {
        let provider = provider ?? DI.container.resolve(BO.Provider.self)!
        return Observable.create({ observer -> Disposable in
            let cancellable = provider.typedRequest(self,
                                                    callbackQueue: nil,
                                                    progress: nil,
                                                    completion: { result in
                                                        switch result {
                                                        case .success(let value):
                                                            observer.onNext(value)
                                                            observer.onCompleted()
                                                        case .failure(let error):
                                                            observer.onError(error)
                                                        }
            })
            return Disposables.create {
                cancellable.cancel()
            }
        })
    }
}

