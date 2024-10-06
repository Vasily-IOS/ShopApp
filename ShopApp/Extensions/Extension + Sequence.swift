//
//  Extension + Sequence.swift
//  ShopApp
//
//  Created by Василий on 30.09.2024.
//

import Foundation

extension Sequence {
    func map<T>(_ keyPath: KeyPath<Element, T>) -> [T] {
        return map { $0[keyPath: keyPath] }
    }
}
