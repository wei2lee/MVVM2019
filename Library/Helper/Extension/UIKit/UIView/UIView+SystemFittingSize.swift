//
//  UIView+SystemFittingSize.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 09/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension UIView {
    func getSystemFittingSize(targetWidth: CGFloat? = nil) -> CGSize {
        let targetWidth = targetWidth ?? self.bounds.width
        var targetSize:CGSize = UIView.layoutFittingCompressedSize;
        let verticalFittingPriority:UILayoutPriority = UILayoutPriority(rawValue: Float(1))
        targetSize.width = targetWidth
        let fittingSize = self.systemLayoutSizeFitting(targetSize,
                                                       withHorizontalFittingPriority: UILayoutPriority.required,
                                                       verticalFittingPriority: verticalFittingPriority)
        return fittingSize
    }
}
