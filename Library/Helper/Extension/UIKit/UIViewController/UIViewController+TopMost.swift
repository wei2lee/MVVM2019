//
//  UIViewController+TopMost.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 27/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension UIViewController {
    var topMost: UIViewController {
        let vc = self
        var ret:UIViewController = vc
        repeat {
            if let presented = ret.presentedViewController {
                ret = presented
            } else {
                break
            }
        } while(true)
        return ret
    }
    
    var bottomMost: UIViewController {
        let vc = self
        var ret:UIViewController = vc
        repeat {
            if let presenting = ret.presentingViewController {
                ret = presenting
            } else {
                break
            }
        } while(true)
        return ret
    }
    
    var keyRootTopMost: UIViewController {
        return UIViewController.keyRoot.topMost
    }
    
    var keyRootBottomMost: UIViewController {
        return UIViewController.keyRoot.bottomMost
    }
    
    static var keyRoot: UIViewController {
        return UIApplication.shared.keyWindow!.rootViewController!
    }
}

