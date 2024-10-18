//
//  ProductJson.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import Foundation

struct ProductJsonModel: Codable, Equatable, Hashable {
    let data: ProductCategoryModel
}

struct ProductCategoryModel: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let name: String
    let products: [ProductModel]
}

struct ProductModel: Codable, Identifiable, Equatable, Hashable {
    let id: Int
    let category: Int
    let color: String
    let name: String
}
