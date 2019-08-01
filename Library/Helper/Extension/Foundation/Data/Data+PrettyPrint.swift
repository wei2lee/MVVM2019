//
//  Data+PrettyPrint.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 27/03/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension Data {
    func prettyPrintedJSONString() throws -> String { /// NSString gives us a nice sanitized debugDescription
        let object = try JSONSerialization.jsonObject(with: self, options: [])
        let data = try JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted])
        let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        return (prettyPrintedString ?? NSString()) as String
    }
}
