//
//  AIAProvider.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Moya
import Result
import RxSwift
import RxCocoa

extension AIA {
    public class Provider : MoyaProvider<AIA.UntypedBaseTarget> {
        static let shared = Provider()
        
        
        func requestTyped<I, O>(_ target: AIA.BaseTarget<I, O>,
                            callbackQueue: DispatchQueue? = .none,
                            progress: ProgressBlock? = .none,
                            completion: @escaping ((_ result: Result<O, MoyaError>) -> ())) -> Cancellable where O: AIA.ResponseBase {
            
            return self.request(target as AIA.UntypedBaseTarget,
                                callbackQueue: callbackQueue,
                                progress: progress,
                                completion: { result -> () in
                                    switch result {
                                    case .success(let response):
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

extension AIA.BaseTarget where O : AIA.ResponseBase {
    func request(provider: AIA.Provider? = nil) -> Observable<O> {
        let provider = provider ?? AIA.Provider.shared
        return Observable.create({ observer -> Disposable in
            let cancellable = provider.requestTyped(self,
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
