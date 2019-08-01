//
//  Data+Image.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 16/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit

extension Data {
    var toBase64String: String? {
        return self.base64EncodedString()
    }
    
    func compressImage(_ maxSizeInKb: Int) -> Data {
        let maxSizeInByte = maxSizeInKb * 1024
        var isCompress = true
        var imageData: Data?
        var compressRatio: CGFloat = 0.9
        while (isCompress && compressRatio >= 0.1) {
            guard let image = UIImage(data: self) else {
                return self
            }
            if let data = image.jpegData(compressionQuality: compressRatio) {
                if maxSizeInByte > data.count || fabsf(Float(compressRatio)) == fabsf(0.1) {
                    isCompress = false
                    imageData = data
                } else {
                    compressRatio -= 0.1
                }
                print("The final compressRation :: \(compressRatio)")
            }
        }
        
        if let data = imageData {
            return data
        } else {
            return self
        }
    }
}
