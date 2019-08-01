//
//  PresentErrorProtocol.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 22/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

@objc protocol PresentErrorProtocol: class {
    func present(error: Error, completion: @escaping ()->())
}
extension PresentErrorProtocol {
    func present(error: Error) -> Driver<Void> {
        return Observable<Void>.create { observer -> Disposable in
            self.present(error: error, completion: {
                observer.onNext(())
                observer.onCompleted()
            })
            return Disposables.create()
        }
        .asDriverOnErrorJustComplete()
    }
}

