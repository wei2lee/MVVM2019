//
//  MoyaLoggerPlugin.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Result
import Moya
import XCGLogger

/// Logs network activity (outgoing requests and incoming responses).
public final class MoyaLoggerPlugin: PluginType {
    fileprivate var targetId: Int = 0
    func createTargetId(_ target: TargetType) -> String {
        targetId += 1
        if let object = target as? NSObject {
            object.aoId = String(targetId)
            return object.aoId ?? ""
        }
        return ""
    }
    func getTargetId(_ target: TargetType) -> String {
        if let object = target as? NSObject {
            return object.aoId ?? ""
        } else {
            return ""
        }
    }
    
    /// Initializes a NetworkLoggerPlugin.
    public init() {
    }
    
    public func willSend(_ request: RequestType, target: TargetType) {
        let idstr = createTargetId(target)
        
        guard let request = request.request, let method = request.httpMethod else {
            Log.info("[id:\(idstr)] XXX XXX: \ninvalid request\n", userInfo: Tag.network.dictionary)
            return
        }
        
        guard let path = request.url?.absoluteString else {
            Log.info("[id:\(idstr)] XXX \(method): \ninvalid url\n", userInfo: Tag.network.dictionary)
            return
        }
        
        let headerDebugString : String
        if request.allHTTPHeaderFields == nil || request.allHTTPHeaderFields!.isEmpty {
            headerDebugString = "\n[Missing http request header]"
        } else {
            let headerJSONString = request.allHTTPHeaderFields?.jsonString(prettify: true) ?? ""
            headerDebugString = "\nHttp request header : \(headerJSONString)"
        }
        
        if let data = request.httpBody {
            do {
                let body: String
                body = try data.prettyPrintedJSONString()
                
                Log.info("[id:\(idstr)] \(method) \(path): \(headerDebugString)\nHttp request body[\(data.count) bytes]  : \n\(body)\n", userInfo: Tag.network.dictionary)
            } catch {
                let body = data.string(encoding: .utf8) ?? ""
                Log.info("[id:\(idstr)] \(method) \(path): \(headerDebugString)\nHttp request body[\(data.count) bytes] : \n\(body)\n", userInfo: Tag.network.dictionary)
            }
            
        } else {
            Log.info("[id:\(idstr)] \(method) \(path): \(headerDebugString)\n[Missing http request body]", userInfo: Tag.network.dictionary)
        }
    }
    
    public func didReceive(_ result: Result<Moya.Response, MoyaError>, target: TargetType) {
        let idstr = getTargetId(target)
        let withBody = true
        let dataResponse: (request: URLRequest?, response: HTTPURLResponse?, error: Error?, data: Data?)
        switch result {
        case .failure(let error): dataResponse = (request: error.response?.request, response: error.response?.response, error: error, data: error.response?.data)
        case .success(let value): dataResponse = (request: value.request, response: value.response, error: nil, data: value.data)
        }
        
        let path = dataResponse.request?.url?.absoluteString ?? ""
        let isFileURL = path.lowercased().starts(with: "file://") || (dataResponse.response == nil && dataResponse.data != nil)
        if dataResponse.response == nil && !isFileURL {
            if let moyaError = dataResponse.error as? MoyaError {
                switch moyaError {
                case .underlying(let e, _):
                    Log.info("(id:\(idstr) XXX \(path): \n:\(e)\n", userInfo: Tag.network.dictionary)
                default:
                    Log.info("(id:\(idstr) XXX \(path): \n:\(moyaError)\n", userInfo: Tag.network.dictionary)
                }
            } else {
                Log.info("(id:\(idstr) XXX \(path): \n\(String(describing: dataResponse.error))\n", userInfo: Tag.network.dictionary)
            }
            return
        }
        let statusCode:Int? = dataResponse.response?.statusCode
        let statusCodeString = (statusCode.flatMap { "\($0)" }) ?? "XXX"
        
        let headerDebugString : String
        if dataResponse.response?.allHeaderFields == nil || (dataResponse.response?.allHeaderFields)!.isEmpty {
            headerDebugString = "\n[Missing http response header]"
        } else {
            let headerJSONString = dataResponse.response?.allHeaderFields.jsonString(prettify: true) ?? ""
            headerDebugString = "\nHttp request header : \(headerJSONString)"
        }
        
        if let data = dataResponse.data {
            
            if withBody {
                do {
                    let body = try data.prettyPrintedJSONString()
                    
                    Log.info("[id:\(idstr)] \(statusCodeString) \(path): \(headerDebugString)\nHttp response body[\(data.count) bytes] :\n\(body)\n", userInfo: Tag.network.dictionary)
                } catch {
                    let body = data.string(encoding: .utf8) ?? ""
                    Log.info("[id:\(idstr)] \(statusCodeString) \(path): \(headerDebugString)\nHttp response body[\(data.count) bytes] :\n\(body)\n", userInfo: Tag.network.dictionary)
                }
                
            } else {
                //Log.info("[id:\(idstr)] \(statusCodeString) \(path): \nHttp response body[\(data.count) bytes]", userInfo: Tag.network.dictionary)
            }
            
        } else {
            Log.info("[id:\(idstr)] \(statusCodeString) \(path): \(headerDebugString)\n[Missing http response body]", userInfo: Tag.network.dictionary)
        }
    }
}


