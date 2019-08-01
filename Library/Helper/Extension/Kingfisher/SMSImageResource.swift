//
//  ImageResource.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 05/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Kingfisher

struct SMSImageResource {
    var resource:Resource?
    var image: UIImage?
    var placeholder:Placeholder?
    
    init(resource: Resource?, placeholder: UIImage? = nil) {
        self.resource = resource
        self.image = nil
        self.placeholder = placeholder
    }
    init(image: UIImage?, placeholder: UIImage? = nil) {
        self.resource = nil
        self.image = image
        self.placeholder = placeholder
    }
}

extension KingfisherWrapper where Base : UIImageView {
    func setImage(with resource:SMSImageResource?) {
        if let value = resource?.image {
            self.base.kf.cancelDownloadTask()
            self.base.image = value
        } else if let value = resource?.resource {
            self.base.kf.setImage(with: value, placeholder: resource?.placeholder)
        } else {
            self.base.kf.cancelDownloadTask()
            let nilResource: Resource? = nil
            self.base.kf.setImage(with: nilResource, placeholder: resource?.placeholder)
        }
    }
}
