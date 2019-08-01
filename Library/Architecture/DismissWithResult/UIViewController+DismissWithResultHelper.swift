//
//  UIViewController+DismissIdentifier.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 08/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwifterSwift

extension UIViewController {
    func exitWithResult(animated: Bool = true, result: DismissResult = .none, completion: (()->())? = nil) {
        if let nav = self.navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: animated, {
                type(of: self).dismissResultRecursively(self, result)
                completion?()
                self.dispose()
            })
        } else if let presenting = self.presentingViewController {
            let presented = presenting.presentedViewController
            presenting.dismiss(animated: animated, completion: {
                if let presented = presented {
                    type(of: self).dismissResultRecursively(presented, result)
                }
                completion?()
                if let presented = presented {
                    presented.dispose()
                }
            })
        }
    }
    
    func closeWithResult(animated: Bool = true, result: DismissResult = .none, completion: (()->())? = nil) {
        if let presenting = self.presentingViewController {
            let presented = presenting.presentedViewController
            presenting.dismiss(animated: animated, completion: {
                if let presented = presented {
                    type(of: self).dismissResultRecursively(presented, result)
                }
                completion?()
                if let presented = presented {
                    presented.dispose()
                }
            })
        }
    }
    
    func popWithResult(animated: Bool = true, result: DismissResult = .none, completion: (()->())? = nil) {
        if let nav = self.navigationController, nav.viewControllers.count > 1 {
            nav.popViewController(animated: animated, {
                type(of: self).dismissResultRecursively(self, result)
                completion?()
                self.dispose()
            })
        }
    }
    
    fileprivate static func dismissResultRecursively(_ viewController: UIViewController, _ result: DismissResult) {
        for child in viewController.children {
            child.onDismissResult.accept(result)
        }
        viewController.onDismissResult.accept(result)
    }
}

extension UIViewController {
    func pushWithIdentifier<T : UIViewController>(_ viewController: T, animated: Bool = true, identifier: Any? = nil, intent: Any? = nil,configureDest: ((T)->())? = nil) -> Single<DismissResult> {
        let dest = viewController
        //let source = self
        //dest.intent = intent
        dest.dismissIdentifier = identifier
        configureDest?(dest)
        self.navigationController?.pushViewController(dest, animated: animated)
        return dest.onDismissResult.asObservable().take(1).asSingle()
    }
}

extension UIViewController {
    func presentWithIdentifier<T : UIViewController>(_ viewController: T, animated: Bool = true, identifier: Any? = nil, intent: Any? = nil, configureDest: ((T)->())? = nil) -> Single<DismissResult> {
        let dest = viewController
        //let source = self
        //dest.intent = intent
        dest.dismissIdentifier = identifier
        configureDest?(dest)
        self.present(viewController, animated: animated)
        return dest.onDismissResult.asObservable().take(1).asSingle()
    }
}

extension UIViewController {
    func changeRoot<T : UIViewController>(_ viewController: T, animated: Bool = true, intent: Any? = nil, configureDest: ((T)->())? = nil) {
        let dest = viewController
        let source = self
        //dest.intent = intent
        configureDest?(dest)
        let sourceRoot = UIApplication.shared.keyWindow!.rootViewController
        UIApplication.shared.keyWindow!.rootViewController = dest
        sourceRoot?.dispose()
        source.dispose()
    }
}
