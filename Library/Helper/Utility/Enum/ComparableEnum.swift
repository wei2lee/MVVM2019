//
//  ComparableEnum.swift
//  AIAAgent
//
//  Created by Yee Chuan Lee on 19/12/2018.
//  Copyright © 2018 lee yee chuan. All rights reserved.
//

import Foundation

protocol ComparableEnum : Comparable, CaseIterable {
    var sortOrder: Int { get }
    static func sortBy(lhs: Self, rhs: Self) -> Bool
}
extension ComparableEnum  {
    var sortOrder: Int {
        for (i, _case) in Self.allCases.enumerated() {
            if _case == self {
                return i
            }
        }
        return 9999
    }
    static func sortBy(lhs: Self, rhs: Self) -> Bool { return lhs < rhs }
    static func < (lhs: Self, rhs: Self) -> Bool { return lhs.sortOrder < rhs.sortOrder }
    static func <= (lhs: Self, rhs: Self) -> Bool { return lhs.sortOrder <= rhs.sortOrder }
    static func >= (lhs: Self, rhs: Self) -> Bool { return lhs.sortOrder >= rhs.sortOrder }
    static func > (lhs: Self, rhs: Self) -> Bool { return lhs.sortOrder > rhs.sortOrder }
}
