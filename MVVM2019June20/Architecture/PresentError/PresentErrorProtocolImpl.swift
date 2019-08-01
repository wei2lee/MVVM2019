//
//  PresentErrorProtocolImpl.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 11/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class PresentErrorProtocolImpl: PresentErrorProtocol {
    weak var base: UIViewController? = nil
    init(base: UIViewController) {
        self.base = base
    }
    func present(error: Error, completion: @escaping ()->()) {
        let title = (error as NSError).localizedTitle.orEmpty
        let message = error.localizedDescription
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let actionTitle = "CLOSE"
        alertController.addAction(title: actionTitle,
                                  style: .default,
                                  isEnabled: true,
                                  handler: { action in
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01, execute: {
                                        //                                            observer.onNext(())
                                        //                                            observer.onCompleted()
                                        completion()
                                    })
        })
        //FIX: UIAlertController showing with delay
        //Reference: https://stackoverflow.com/questions/26449724/uialertcontroller-showing-with-delay
        DispatchQueue.main.async {
            //alertController.show(animated: true)
            self.base?.present(alertController, animated: true, completion: nil)
        }
    }
}

