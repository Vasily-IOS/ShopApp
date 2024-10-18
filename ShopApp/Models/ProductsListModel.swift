//
//  ProductsListModel.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import Foundation

struct ProductsListModel: Equatable, Hashable {
    var allProducts: [ProductModel] = []
    var productsCategory: [ProductCategoryModel] = []
}
