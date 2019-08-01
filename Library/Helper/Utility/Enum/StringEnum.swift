//
//  StringEnum.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 24/10/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation

protocol StringEnum : CaseIterable {
    init?(rawValue:String)
    static func mapRawValue(_ rawValue: String) -> Self?
    static var casesWithNRawValues:[(Self,String)] { get }
    static var caseNormalizedRawValues:[String] { get }
    static func compareNormalizedRawValue(_ leftEnumValue:Self, _ leftNRawValue: String, _ rightRawValue: String) -> Bool
    static func normalize(_ value:String) -> String
}
extension StringEnum where Self : RawRepresentable, Self.RawValue == String {
    init?(rawValue:String) {
        if let ret = Self.mapRawValue(rawValue) {
            self = ret
        } else {
            return nil
        }
    }
    static func mapRawValue(_ rawValue: String) -> Self? {
        let cases = Self.casesWithNRawValues
        let caseCompare = Self.compareNormalizedRawValue
        if let index = cases.firstIndex(where: { caseCompare($0.0, $0.1, rawValue) } ) {
            return cases[index].0
        } else {
            //print("Cannot initliaze \(type(of: EnumType.self)) for \(rawValue)")
            return nil
        }
    }
    static var casesWithNRawValues:[(Self,String)] {
        return zip(Self.allCases,
                   Self.caseNormalizedRawValues )
            .map { ($0,$1) }
    }
    static var caseNormalizedRawValues:[String] {
        return Self.allCases.map { Self.normalize($0.rawValue) }
    }
    static func compareNormalizedRawValue(_ leftEnumValue:Self, _ leftNRawValue: String, _ rightRawValue: String) -> Bool {
        let rightNRawValue = Self.normalize(rightRawValue)
        return leftNRawValue == rightNRawValue
    }
    static func normalize(_ value:String) -> String {
        return value
    }
}
