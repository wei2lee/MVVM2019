//
//  App+DI.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import Swinject
import UIKit
import SwifterSwift

struct DI {
    static let container = Container()
    static let resolver: Resolver = { return container.synchronize() }()
}

extension UIStoryboard {
    func instantiateViewController<T>(withIdentifier identifier: String) -> T {
        return self.instantiateViewController(withIdentifier: identifier) as! T
    }
}

extension DI {
    static func registerViewController<T>(storyboard: UIStoryboard, type:T.Type, identifier: String) {
        DI.container.register(T.self) { r -> T in
            return storyboard.instantiateViewController(withIdentifier: identifier)
        }
    }
}

protocol DIRegistor {
    static func register()
}
protocol DIModuleRegistor {
    static func registerView()
    static func registerViewModel()
}
extension DIModuleRegistor {
    static func register() {
        registerViewModel()
        registerView()
    }
}

@propertyWrapper
struct Injected<Service> {
    private var service: Service?
    init() { }
    public var wrappedValue: Service {
        mutating get {
            if service == nil {
                service = DI.resolver.resolve(Service.self)
            }
            return service!
        }
        mutating set {
            service = newValue
        }
    }
}
