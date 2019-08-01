//
//  BOMockResponsePlugin.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Moya

extension BO {
    class MockProvider: BO.Provider {
        public override init(endpointClosure: @escaping MoyaProvider<Target>.EndpointClosure = MockProvider.endpointMapping,
                             requestClosure: @escaping MoyaProvider<Target>.RequestClosure = Provider.defaultRequestMapping,
                             stubClosure: @escaping MoyaProvider<Target>.StubClosure = MockProvider.stubBehavior,
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
        
        static let mockBasePath: String = Bundle.main.bundlePath.appendingPathComponent("mock/BO")
        
        public final class func endpointMapping(for target: BO.UntypedBaseTarget) -> Endpoint {
            //Activation
            if target is EndPoint.RequestActivation {
                return createEndPoint(target: target, dataPath: "Activation/requestactivation_response.json")
            }
            if let target = target as? EndPoint.VerifyActivation {
                let input = target.i!
                let code = input.activationCode
                if code == "111111" {
                    return createEndPoint(target: target, dataPath: "Activation/verifyactivation_response.json")
                } else {
                    return createEndPoint(target: target, dataPath: "Activation/verifyactivationfail_response.json")
                }
            }
            //Profile
            
            //Session
            if let target = target as? EndPoint.Login {
                let input = target.i!
                if input.username == "A" && input.password == "a" {
                    return createEndPoint(target: target, dataPath: "Session/login_response.json")
                } else {
                    return createEndPoint(target: target, dataPath: "Session/loginfail_response.json")
                }
            }
            if target is EndPoint.Logout {
                return createEndPoint(target: target, dataPath: "Session/logout_response.json")
            }
            if target is EndPoint.Revalidate {
                return createEndPoint(target: target, dataPath: "Session/revalidate_response.json")
            }
            return Endpoint(
                url: URL(target: target).absoluteString,
                sampleResponseClosure: { .networkResponse(200, Data()) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        
        public final class func createEndPoint(target: BO.UntypedBaseTarget, dataPath: String) -> Endpoint {
            return Endpoint(
                url: createURL(dataPath: dataPath),
                sampleResponseClosure: { .networkResponse(200, createData(dataPath: dataPath)) },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }
        
        public final class func createURL(dataPath: String) -> String {
            let path = MockProvider.mockBasePath.appendingPathComponent(dataPath)
            return path
        }
        
        public final class func createData(dataPath: String) -> Data {
            let path = createURL(dataPath: dataPath)
            let url = URL(fileURLWithPath: path)
            let data = try! Data(contentsOf: url)
            return data
        }
        
        public final class func stubBehavior(_: BO.UntypedBaseTarget) -> Moya.StubBehavior {
            let maxDelayed: TimeInterval = 2.0
            let apiDelay:TimeInterval = TimeInterval(arc4random_uniform(100)) / 100.0 * maxDelayed
            return .delayed(seconds: apiDelay)
        }
    }
}
