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
                             plugins: [PluginType] = [RequestPlugin(), ResponsePlugin(), MoyaLoggerPlugin()],
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
                                completion: @escaping ((_ result: Result<O, Swift.Error>) -> ()) = { _ in }) -> Cancellable where O: Decodable {
            
            func validateResponseError(_ response: Moya.Response) -> MoyaError? {
                do {
                    let errorResponse = try response.map(BO.BaseResponse.self)
                    if let boError = BO.Error(response: errorResponse) {
                        let error = MoyaError.underlying(boError, response)
                        return error
                    }
                    return nil
                } catch {
                    print("\(error)")
                    return nil
                }
            }
            
            func mapError(_ moyaError: MoyaError) -> Swift.Error {
                switch moyaError {
                case .imageMapping(_):
                    return BO.Error.generic.error.with(underlyingError: moyaError)
                case .jsonMapping(_):
                    return BO.Error.generic.error.with(underlyingError: moyaError)
                case .stringMapping(_):
                    return BO.Error.generic.error.with(underlyingError: moyaError)
                case .objectMapping(_, _):
                    return BO.Error.generic.error.with(underlyingError: moyaError)
                case .encodableMapping(_):
                    return BO.Error.generic.error.with(underlyingError: moyaError)
                case .statusCode(_):
                    return BO.Error.generic.error.with(underlyingError: moyaError)
                case .underlying(let error, _):
                    if let urlError = error as? URLError, urlError.code  == URLError.Code.notConnectedToInternet {
                        return NetworkError.noInternetConnection.error.with(underlyingError: urlError as NSError)
                    }
                    if let urlError = error as? URLError {
                        switch urlError {
                        case URLError.timedOut, URLError.cannotFindHost, URLError.cannotConnectToHost:
                            return NetworkError.connectionTimeout.error.with(underlyingError: urlError as NSError)
                        default:
                            return NetworkError.generic.error.with(underlyingError: urlError as NSError)
                        }
                    }
                    return error
                case .requestMapping(_):
                    return BO.Error.generic.error.with(underlyingError: moyaError)
                case .parameterEncoding(_):
                    return BO.Error.generic.error.with(underlyingError: moyaError)
                }
            }
            
            return self.request(target as BO.UntypedBaseTarget,
                                callbackQueue: callbackQueue,
                                progress: progress,
                                completion: { result -> () in
                                    switch result {
                                    case .success(let response):
                                        if let error = validateResponseError(response) {
                                            let result: Result<O, Swift.Error> = .failure(mapError(error))
                                            completion(result)
                                            return
                                        }
                                        do {
                                            let object = try response.map(O.self)
                                            let result: Result<O, Swift.Error> = .success(object)
                                            completion(result)
                                        } catch {
                                            let error: MoyaError = error as! MoyaError
                                            let result: Result<O, Swift.Error> = .failure(mapError(error))
                                            completion(result)
                                        }
                                        break
                                    case .failure(let error):
                                        let result: Result<O, Swift.Error> = .failure(mapError(error))
                                        completion(result)
                                    }
                                    
                                    
            })
        }
    }
}

extension BO.BaseTarget where O : Codable {
    func request(provider: BO.Provider? = nil) -> Observable<O> {
        let provider = provider ?? DI.resolver.resolve(BO.Provider.self)!
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

