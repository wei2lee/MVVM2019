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

class BaseViewController<VM> : UIViewController, BaseViewType, ViewType, DisposeOnWillRemoveFromParentType, BaseNavigationChildViewController where VM : BaseViewModelType {
    //MARK: State
    var disposeOnWillRemoveFromParent: Bool = true
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
    override func removeFromParent() {
        super.removeFromParent()
        //Log.debug("\(self)@parent = \(parent)")
    }
    
    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        //Log.debug("\(self)@parent = \(parent)")
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        //Log.debug("\(self)@parent = \(parent)")
        if parent == nil {
            if disposeOnWillRemoveFromParent {
                dispose()
            }
        }
    }

    override func dispose() {
        super.dispose()
    }
    
    deinit {
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
