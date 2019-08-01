//
//  RxImagePickerDelegateProxy.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 28/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa

class RxImagePickerDelegateProxy
: RxNavigationControllerDelegateProxy, UIImagePickerControllerDelegate {
    
    public init(imagePicker: UIImagePickerController) {
        super.init(navigationController: imagePicker)
    }
}
