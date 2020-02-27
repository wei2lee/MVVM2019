//
//  BOHTTPRequestPlugin.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 27/02/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Moya
import SwiftDate

extension BO {
    public struct HTTPRequestPlugin: PluginType {
        let privateKeyClosure: () -> String
        let timestampFormat: String
        public init() {
            let config = DI.container.resolve(BuildConfigType.self)!
            privateKeyClosure = {
                return config.boSignatureRequestPrivateKey
            }
            timestampFormat = DateFormats.yyyyMMdd_HHmmss
        }

        public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
            guard let boTarget = target as? BO.UntypedBaseTarget else {
                return request
            }
            guard boTarget.createSignatureForRequest else {
                return request
            }
            var req = request
            let dateProvider = DI.container.resolve(DateProviderType.self)!
            let now = dateProvider.now
            let timestampString = now.inLocal.toString(.custom(DateFormats.yyyyMMdd_HHmmss))
            let timestampData = timestampString.data(using: .ascii) ?? Data()
            let privateKeyData = privateKeyClosure().data(using: .ascii) ?? Data()
            let privateKeyDataBase64String = privateKeyData.toBase64String ?? ""
            let httpData = req.httpBody ?? Data()
            let unencryptedSignature: Data = {
                var ret = Data()
                ret.append(timestampData)
                ret.append(httpData)
                ret.append(privateKeyData)
                return ret
            }()
            let encryptedSignature: Data = unencryptedSignature //TODO get signature from the Data
            let encryptedSignatureBase64String: String = String(data: unencryptedSignature, encoding: .utf8) ?? "" //encryptedSignature.toBase64String ?? ""
            req.setValue(encryptedSignatureBase64String, forHTTPHeaderField: "sig")
            req.setValue(timestampString, forHTTPHeaderField: "timestamp")
            req.setValue(privateKeyDataBase64String, forHTTPHeaderField: "privatekey")
            return req
        }
    }
}
