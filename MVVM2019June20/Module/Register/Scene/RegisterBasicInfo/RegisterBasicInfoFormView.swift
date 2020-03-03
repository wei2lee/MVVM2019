//
//  RegisterBasicInfoFormView.swift
//  MVVM2019June20
//
//  Created by lee yee chuan on 02/03/2020.
//  Copyright © 2020 Yee Chuan Lee. All rights reserved.
//

import UIKit

class RegisterBasicInfoFormView: UIStackView {
    @IBOutlet var firstNameRow: TextRow!
    @IBOutlet var lastNameRow: TextRow!
    @IBOutlet var emailRow: TextRow!
    @IBOutlet var passwordRow: TextRow!
    @IBOutlet var confirmPasswordRow: TextRow!
    @IBOutlet var nextButton: UIButton!
    
    var rows: [Validatable] {
        return [firstNameRow,
            lastNameRow,
            emailRow,
            passwordRow,
            confirmPasswordRow]
    }
    
    func validate() {
        rows.forEach { $0.validate() }
    }
    
    var isAllRowsValidateSuccess: Bool {
        return !rows.map { $0.validationState }
            .contains(where: { !$0.isSuccess })
    }
}
