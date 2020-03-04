//
//  PresentDialogProtocolImpl.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 11/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PresentDialogProtocolImpl: PresentDialogProtocol {
    weak var base: UIViewController? = nil
    init(base: UIViewController) {
        self.base = base
    }
    func presentDialog(title: String?, message: String?, actions: [String]) -> Driver<Int> {
        guard base != nil else { return .empty() }
        return Observable<Int>.create { observer -> Disposable in
            let alertController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
            for (actionIndex,actionTitle) in actions.enumerated() {
                alertController.addAction(title: actionTitle,
                                          style: .default,
                                          isEnabled: true,
                                          handler: { action in
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                                                observer.onNext(actionIndex)
                                                observer.onCompleted()
                                            })
                })
            }
            //FIX: UIAlertController showing with delay
            //Reference: https://stackoverflow.com/questions/26449724/uialertcontroller-showing-with-delay
            DispatchQueue.main.async {
                //alertController.show(animated: true)
                self.base?.present(alertController, animated: true, completion: nil)
            }
            return Disposables.create()
            }
            .asDriverOnErrorJustComplete()
    }
    
    func presentDialog(title: String?, message: String?, actions: [DialogAction]) -> Driver<DialogAction> {
        guard base != nil else { return .empty() }
        let actionTitles = actions.map { $0.title ?? "" }
        return presentDialog(title: title,
                             message: message,
                             actions: actionTitles)
            .map { actionIndex in
                return actions[actionIndex]
        }
    }
    
    func presentDialog(title: String?, message: String?, action: DialogAction) -> Driver<DialogAction> {
        guard base != nil else { return .empty() }
        return presentDialog(title: title,
                             message: message,
                             actions: [action])
    }
}
