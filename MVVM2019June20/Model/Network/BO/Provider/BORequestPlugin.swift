//
//  BORequestPlugin.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 27/02/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Moya
import SwiftDate

extension BO {
    public class RequestPlugin: PluginType {
        @Injected var dateProvider: DateProviderType
        let privateKeyClosure: () -> String
        let timestampFormat: String
        public init() {
            let config = DI.resolver.resolve(BuildConfigType.self)!
            privateKeyClosure = {
                return config.boRequestSignaturePrivateKey
            }
            timestampFormat = DateFormats.yyyyMMdd_HHmmss
        }

        public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
            guard let boTarget = target as? BO.UntypedBaseTarget else {
                return request
            }
            var req = request
            if boTarget.createSignatureForRequest {
                let dateProvider = self.dateProvider
                let now = dateProvider.now
                let timestampString = now.inLocal.toString(.custom(DateFormats.yyyyMMdd_HHmmss))
                let timestampData = timestampString.data(using: .ascii) ?? Data()
                let privateKeyData = privateKeyClosure().data(using: .ascii) ?? Data()
                let httpData = req.httpBody ?? Data()
                let unencryptedSignatureData: Data = {
                    var ret = Data()
                    ret.append(timestampData)
                    ret.append(httpData)
                    ret.append(privateKeyData)
                    return ret
                }()
                let encryptedSignatureData: Data = createEncryptedSignature(unencryptedSignatureData)
                let based64EncryptedSignatureString: String = createBase64( String(data: encryptedSignatureData, encoding: .utf8) ?? "" )
                req.setValue(based64EncryptedSignatureString, forHTTPHeaderField: BO.HTTPRequestHeaderKey.sig.rawValue)
                req.setValue(timestampString, forHTTPHeaderField: BO.HTTPRequestHeaderKey.timestamp.rawValue)
            }
            return req
        }
        
        func createBase64(_ string: String) -> String {
            return string
        }
        
        func createEncryptedSignature(_ data: Data) -> Data {
            return data
        }
    }
}
