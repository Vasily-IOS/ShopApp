//
//  ProductJson.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import Foundation

struct ProductJson: Codable, Equatable, Hashable {
    let data: ProductCategory
}

struct ProductCategory: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let items: [Product]
}

struct Product: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let category: Int
    let color: String
    let name: String
}
