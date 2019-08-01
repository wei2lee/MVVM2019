//
//  AIABaseTarget.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

protocol AIAAccessTokenAuthorizable {
    var loginSession: LoginSession? { get }
}

protocol AIABaseTargetType {
    associatedtype I
    associatedtype O
}

extension AIA {
    class UntypedBaseTarget: TargetType {
        //Inject
        var loginSession: LoginSession? = nil
        
        //<TargetType>
        var baseURL: URL { return URL(string: "http://www.aiacustomapp.com/api")! }
        
        var path: String { return "" }
        
        var method: Moya.Method { return .post }
        
        var sampleData: Data { return Data() }
        
        var task: Task { return .requestPlain }
        
        var headers: [String : String]? { return nil }
        
    }
    
    class BaseTarget<I, O>: UntypedBaseTarget, AIABaseTargetType {
        
        var i: I!
        
        init(input: I) {
            self.i = input
        }
    }
}
