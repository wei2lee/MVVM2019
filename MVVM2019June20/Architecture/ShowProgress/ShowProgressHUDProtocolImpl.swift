//
//  ShowProgressHUDProtocolImpl.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 11/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD
import SwifterSwift

class ShowProgressHUDProtocolImpl: ShowProgressHUDProtocol {
    weak var base: UIView? = nil
    init(base: UIView) {
        self.base = base
    }
    func setupShowProgressHUD() {
        guard let base = base else { return }
        
        if base.mbProgressHUD == nil {
            base.mbProgressHUD = MBProgressHUD(view: base)
        }
        base.mbProgressHUD!.animationType = .fade
        let color = UIColor(hexString: UIColor.black.hexString, transparency: 0.5)
        base.mbProgressHUD!.backgroundView.backgroundColor = color
        base.mbProgressHUD!.removeFromSuperViewOnHide = true
    }
    
    func showProgressHUD() {
        guard let base = base else { return }
        
        setupShowProgressHUD()
        base.addSubview(base.mbProgressHUD!)
        base.mbProgressHUD!.frame = base.bounds
        base.mbProgressHUD!.backgroundView.frame = base.mbProgressHUD!.bounds
        base.mbProgressHUD!.show(animated: true)
    }
    func showProgressHUD(label:String) {
        guard let base = base else { return }
        setupShowProgressHUD()
        base.mbProgressHUD?.label.text = label
        base.addSubview(base.mbProgressHUD!)
        base.mbProgressHUD!.show(animated: true)
    }
    
    func hideProgressHUD() {
        guard let base = base else { return }
        base.mbProgressHUD?.hide(animated: true)
    }
}
