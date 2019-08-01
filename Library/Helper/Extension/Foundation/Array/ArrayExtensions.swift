//
//  Array+Extensions.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 29/04/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension Array {
    var firstIfSingleElementOrNil: Element? {
        return self.count == 1 ? self.first : nil
    }
}

extension Array {
    var orEmpty : Array<Element> {
        return self.isEmpty ? [] : self
    }
}

extension Array where Element : Equatable {
    func appendIfNotDuplicated(_ value: Element?) -> Array<Element> {
        if let value = value {
            if !self.contains(value) {
                return self + [value]
            }
        }
        return self
    }
    
    func appendIfNotDuplicated(_ closure: () -> (Element?) ) -> Array<Element> {
        return appendIfNotDuplicated(closure())
    }
}

extension Array where Element : Equatable {
    func transformed(_ closure: (Array<Element>)->(Array<Element>)) -> Array<Element> {
        return closure(self)
    }
}
