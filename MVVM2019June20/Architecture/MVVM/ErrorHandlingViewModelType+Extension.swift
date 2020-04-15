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
        error.do(onNext: { [weak self](error : Error) in
            guard let self = self else { return }
            if let error = BO.Error(error: error.error) {
                //if error is Api Error, perform custom logic based on error type
                switch error {
                case .invalidToken(_):
                    //invalidToken: prompt error dialog and route to login screen on dialog dismissed
                    input.view?.present(error: error)
                        .do(onNext: {
                            //routeToLoginScreen
                        })
                        .drive()
                        .disposed(by: self.disposeBag)
                case .serverDown(_):
                    //serverDown: prompt error dialog and route to login screen on dialog dismissed
                    input.view?.present(error: error)
                        .do(onNext: {
                            //routeToServerDownScreen
                        })
                        .drive()
                        .disposed(by: self.disposeBag)
                    
                    //example: set offline mode on serverDown
                    //offlineManager.setOfflineMode(true)
                case .response(_):
                    //response (unify error response): prompt error dialog.
                    input.view?.present(error: error)
                        .drive()
                        .disposed(by: self.disposeBag)
                default:
                    //do nothing
                    break
                }
            } else {
                //if error is not Api Error, prompt error dialog
                self.processError(view: input.view, error: error)
                    .drive()
                    .disposed(by: self.disposeBag)
            }
        })
        .drive()
        .disposed(by: disposeBag)
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

