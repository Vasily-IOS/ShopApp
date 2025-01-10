//
//  CreateListEvent.swift
//  ShopApp
//
//  Created by Василий on 18.10.2024.
//

import Foundation

enum CreateListEvent {
    case cleanSearchText
    case sort
    case addProduct(ProductUIModel)
    case removeProduct(ProductUIModel)
    case toggleProductSelection(ProductUIModel)
    case addProductToolBar
}
