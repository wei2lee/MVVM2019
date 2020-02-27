//
//  BOBaseTarget.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 23/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

extension BO {
    class UntypedBaseTarget: TargetType {
        //<TargetType>
        var baseURL: URL { return URL(string: "http://www.omdbapi.com/")! }
        
        var path: String { return "" }
        
        var method: Moya.Method { return .post }
        
        var sampleData: Data { return Data() }
        
        var task: Task { return .requestPlain }
        
        var headers: [String : String]? { return nil }
        
        var createSignatureForRequest: Bool { return true }
        
        var validateSignatureForResponse: Bool { return true }
    }
    
    class BaseTarget<I, O>: UntypedBaseTarget {
        var i: I!
        
        override var task: Task {
            if let parameters = i as? Encodable {
                return .requestParameters(parameters: parameters.dictionary ?? [:], encoding: JSONEncoding())
            } else {
                return super.task
            }
        }
        
        init(input: I) {
            self.i = input
        }
    }
}

