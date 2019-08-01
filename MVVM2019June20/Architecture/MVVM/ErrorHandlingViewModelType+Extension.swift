//
//  ErrorHandlingViewModelType+Extension.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 04/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

protocol ExitToDashboardViewType {
    func exitToDashboard()
}

extension ErrorHandlingViewModelType where Self: BaseViewModel {
    func transformErrorHandling(input:ErrorHandlingInput) -> ErrorHandlingOutput {
        let error = input.error
        error.flatMapLatest {
            self.processError(view: input.view, error: $0)
        }
        .drive().disposed(by: disposeBag)
        return .none()
    }
    
    func processError(view:ErrorHandlingViewType?, error: Error) -> Driver<NSError> {
        return processOtherError(view: view, error: error)
    }
    
    func processUnauthorizedError(view:ErrorHandlingViewType?, error: Error) -> Driver<NSError> {
        guard let view = view else { return .just(error as NSError) }
        return view.present(error: error).map({ _ in error as NSError })
    }
    
    func processOtherError(view:ErrorHandlingViewType?, error: Error) -> Driver<NSError> {
        guard let view = view else { return .just(error as NSError) }
        return view.present(error: error).map({ _ in error as NSError })
    }
}

