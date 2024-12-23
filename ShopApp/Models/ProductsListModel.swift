//
//  ProductsListModel.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import Foundation

struct ProductsListModel: Equatable, Hashable {
    var allProducts: [SingleProductJsonModel] = []
    var productsCategory: [ProductCategoryJsonModel] = []
}

// !new!

struct ProductUIModel: Codable, Identifiable, Hashable {
    let id: Int
    let category: Int
    let name: String
    var isSelected: Bool = false
}

struct ProductCategoryUIModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let products: [ProductUIModel]
}

struct ProductsListUIModel: Hashable {
    var allProducts: [ProductUIModel] = []
    var productsCategory: [ProductCategoryUIModel] = []
}

