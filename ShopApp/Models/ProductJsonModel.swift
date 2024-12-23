//
//  ProductJson.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import Foundation

struct ProductJsonModel: Codable, Equatable, Hashable {
    let data: ProductCategoryJsonModel
}

struct ProductCategoryJsonModel: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let products: [SingleProductJsonModel]
}

struct SingleProductJsonModel: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let category: Int
    let color: String
    let name: String
}
