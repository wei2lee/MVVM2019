//
//  MockBaseView.swift
//  ModuleTests
//
//  Created by Yee Chuan Lee on 06/08/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
@testable import MVVM2019June20

class MockBaseView: NSObject, BaseViewType {
    func showProgressHUD() {
        
    }
    
    func showProgressHUD(label: String) {
        
    }
    
    func hideProgressHUD() {
        
    }
    
    func exitToLogin() {
        
    }
    
    func presentDialog(title: String?, message: String?, actions: [String]) -> Driver<Int> {
        return Driver<Int>.just(0).delay(.milliseconds(100))
    }
    
    func presentDialog(title: String?, message: String?, actions: [DialogAction]) -> Driver<DialogAction> {
        return Driver<DialogAction>.just(actions.first!).delay(.milliseconds(100))
    }
    
    func presentDialog(title: String?, message: String?, action: DialogAction) -> Driver<DialogAction> {
        return Driver<DialogAction>.just(action).delay(.milliseconds(100))
    }
    
    var disposeOnWillRemoveFromParent: Bool = false
    
    func showLoginSessionExpire(error: NSError) -> Driver<Void> {
        return .just(())
    }
    
    var isPresentedError: Bool = false
    func present(error: Error, completion: @escaping () -> ()) {
        isPresentedError = true
    }
    
    func exitWithResult(animated: Bool, result: DismissResult, completion: (() -> ())?) {
        
    }
    
    func closeWithResult(animated: Bool, result: DismissResult, completion: (() -> ())?) {
        
    }
    
    func popWithResult(animated: Bool, result: DismissResult, completion: (() -> ())?) {
        
    }
    
    
}
