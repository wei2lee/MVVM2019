//
//  ActivationViewController.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 21/06/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift
import RxBiBinding
import SwifterSwift

class ActivationViewController: BaseViewController<ActivationViewModel> {
    //MARK: outlets
    @IBOutlet var formView: ActivationFormView!
    //MARK: state
    fileprivate lazy var returnKeyHandler: IQKeyboardReturnKeyHandler = {
        let ret = IQKeyboardReturnKeyHandler(controller: self)
        ret.lastTextFieldReturnKeyType = .done
        return ret
    }()
    //MARK: viewCycle
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(ActivationViewModel.self)!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func setupView() {
        super.setupView()
        //NavigationBar
        self.leftBarItem = .back(closure: nil)
        //Form
        formView.activationCodeTextField.spellCheckingType = .no
        formView.activationCodeTextField.keyboardType = .numberPad
        _ = returnKeyHandler
    }
    override func setupTransformInput() {
        super.setupTransformInput()
        viewModel.view = self
        viewModel.startLoad = rx.viewWillAppearForFirstTime
        viewModel.startExit = rx.leftBarButtonItem(.back())
        viewModel.startRequestActivationCode = formView.requestActivationButton.rx.tap.asDriver()
        viewModel.startSubmit = rx.startSubmit
    }
    override func subscribe() {
        super.subscribe()
        disposeBag.insert(
            //Form
            formView.activationCodeTextField.rx.text <-> viewModel.activationCode,
            viewModel.requestActivationStatusText.bind(to: formView.requestActivationStatusLabel.rx.text),
            viewModel.enableRequestActivate.bind(to: formView.requestActivationButton.rx.isEnabled)
        )
    }
}
//MARK: <ActivationViewType>
extension ActivationViewController: ActivationViewType {
    func dismissToLogin() {
        navigationController?.popViewController()
    }
    
    func routeToDashboard() {
        let screen = DI.resolver.resolve(DashboardNavigationControllerType.self)!
        SwifterSwift.sharedApplication.keyWindow?.rootViewController = screen
    }
}
//MARK: rx
extension Reactive where Base : ActivationViewController {
    var startSubmit: Driver<Void> {
        var triggers: [Driver<Void>] = []
        triggers += [base.formView.activateButton.rx.tap.asDriver().asVoid()]
        triggers += [base.formView.activationCodeTextField.rx.shouldReturn.asDriver()]
        return Driver.merge(triggers)
        
    }
}
//MARK: view
class ActivationFormView: UIView {
    @IBOutlet var activationCodeTextField: UITextField!
    @IBOutlet var activateButton: UIButton!
    @IBOutlet var requestActivationButton: UIButton!
    @IBOutlet var requestActivationStatusLabel: UILabel!
}
