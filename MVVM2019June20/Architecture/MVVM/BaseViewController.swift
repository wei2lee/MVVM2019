//
//  BaseViewController.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 28/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BaseViewController<VM> : UIViewController, BaseViewType, ViewType, BaseNavigationChildViewController where VM : BaseViewModelType {
    //MARK: State
    var viewModel: VM! {
        didSet {
            if let vm = viewModel {
                vm.disposed(by: disposeBag)
            }
        }
    }
    //MARK: View Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTransformInput()
        transform()
        subscribe()
    }
    //MARK: <Disposable>
    override func dispose() {
        super.dispose()
        viewModel = nil
    }

    deinit {
        Log.debug("\(self)", userInfo: LogTag.clearup.dictionary)
    }
    //MARK: setupView
    func setupView() {
        
    }
    //MARK: transform
    func setupTransformInput() {
        
    }
    
    func transform() {
        viewModel.transform()
    }
    //MARK: subscribe
    func subscribe() {
        disposeBag.insert(
            viewModel.showLoading.drive(self.rx.isShowProgressHUD)
        )
    }
    //MARK: IBAction
    @IBAction func unwind() {
        
    }
    //MARK: <SMSNavigationChildViewController>
    var isNavigationBarHidden: Bool {
        return false
    }
}
