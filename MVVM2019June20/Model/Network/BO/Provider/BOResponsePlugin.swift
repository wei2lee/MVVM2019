//
//  BOResponsePlugin.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 28/02/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Moya
import SwiftDate

extension BO {
    public struct ResponsePlugin: PluginType {
        let privateKeyClosure: () -> String
        public init() {
            let config = DI.resolver.resolve(BuildConfigType.self)!
            privateKeyClosure = {
                return config.boRequestSignaturePrivateKey
            }
        }

        public func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
            guard let _ = target as? BO.UntypedBaseTarget else {
                return result
            }
            switch result {
            case .success(let response):
                let responseHeaderFields = response.response?.allHeaderFields ?? [:]
                let serverEncryptedSignatureString = createDeBase64( (responseHeaderFields[BO.HTTPResponseHeaderKey.sig.rawValue] as? String) ?? "" )
                let serverEncryptedSignatureData = serverEncryptedSignatureString.data(using: .utf8)
                let timestampString = (response.response?.allHeaderFields[BO.HTTPResponseHeaderKey.timestamp.rawValue] as? String) ?? ""
                let timestampData = timestampString.data(using: .ascii) ?? Data()
                let privateKeyString = privateKeyClosure()
                let privateKeyData = privateKeyString.data(using: .ascii) ?? Data()
                
                let unencryptedSignatureData: Data = {
                    var ret = Data()
                    ret.append(timestampData)
                    ret.append(response.data)
                    ret.append(privateKeyData)
                    return ret
                }()
                
                let encryptedSignatureData: Data = createEncryptedSignature( unencryptedSignatureData )
                let isSignatureMatched = encryptedSignatureData == serverEncryptedSignatureData

                if !isSignatureMatched {
                    return Result.failure(MoyaError.underlying(BO.Error.invalidSignature.error, response))
                }
                return result
            case .failure:
                return result
            }
        }
        
        func createDeBase64(_ string: String) -> String {
            return string
        }
        
        func createEncryptedSignature(_ data: Data) -> Data {
            return data
        }
    }
}
