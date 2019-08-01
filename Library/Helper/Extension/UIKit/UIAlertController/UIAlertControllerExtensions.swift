//
//  UIAlertControllerExtensions.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 16/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift

extension UIAlertController {
    
    struct AlertAction {
        var title: String!
        var style: UIAlertAction.Style
        var leftIcon: UIImage?
        
        static func action(title: String!, style: UIAlertAction.Style = .default, leftIcon: UIImage? = nil) -> AlertAction {
            return AlertAction(title: title, style: style, leftIcon: leftIcon)
        }
        
    }
    
    static func present(
        in viewController: UIViewController,
        title: String?,
        message: String?,
        style: UIAlertController.Style,
        actions: [AlertAction])
        -> Observable<(index: Int, title: String)>
    {
        return Observable.create { observer in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            
            actions.enumerated().forEach { index, action in
                let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                    observer.onNext((index, action.title))
                    observer.onCompleted()
                }
                
                if let icon = action.leftIcon {
                    alertAction.setValue(icon, forKey: "image")
                }
                
                alertController.addAction(alertAction)
            }
            
            viewController.present(alertController, animated: true, completion: nil)
            return Disposables.create { alertController.dismiss(animated: true, completion: nil) }
        }
        
    }
    
}
