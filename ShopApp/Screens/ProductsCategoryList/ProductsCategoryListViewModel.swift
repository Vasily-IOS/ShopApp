//
//  ProductsCategoryListViewModel.swift
//  ShopApp
//
//  Created by Василий on 15.12.2024.
//

import Foundation

extension ProductsCategoryListView {
    @Observable
    final class ViewModel {

        // MARK: - Properties

        var searchText = ""

        var sortedProductByCategory: [ProductModel] = []

        let productsCategory: ProductCategoryModel

        // MARK: - Initializers

        init(productsCategory: ProductCategoryModel) {
            self.productsCategory = productsCategory
            self.sortedProductByCategory = productsCategory.products
        }

        // MARK: - Instance methods

        func sendEvent(_ event: ProductCategoryListEvent) {
            switch event {
            case .clearSearchText:
                searchText.removeAll()
            case .sort:
                sortedProductByCategory = searchText.isEmpty
                ? productsCategory.products
                : productsCategory.products.filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                }
            }
        }

        func isFirstProduct(id: Int) -> Bool {
            id == sortedProductByCategory.first?.id ?? 0
        }

        func isLastProduct(id: Int) -> Bool {
            id == sortedProductByCategory.last?.id ?? 0
        }

        func isOneOnly() -> Bool {
            sortedProductByCategory.count == 1
        }
    }
}
