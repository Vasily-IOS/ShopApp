//
//  ItemModel.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import Foundation

struct Json: Codable, Equatable, Hashable {
    let data: Category
}

struct Category: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let items: [Item]
}

struct Item: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let category: Int
    let color: String
    let name: String
}
