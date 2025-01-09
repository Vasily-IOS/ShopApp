//
//  ProductsCategoryListViewModel.swift
//  ShopApp
//
//  Created by Василий on 15.12.2024.
//

import Foundation
import Combine

extension ProductsCategoryListView {
    @Observable
    final class ViewModel {

        // MARK: - Properties

        var searchText = ""

        let listDescription: String

        private (set) var products: [ProductUIModel] = []

        private var originalProducts: [ProductUIModel] = []

        // MARK: - Initializers

        init(productsCategory: ProductCategoryUIModel) {
            self.listDescription = productsCategory.name
            self.originalProducts = productsCategory.products
            self.products = productsCategory.products
        }

        // MARK: - Instance methods

        func sendEvent(_ event: ProductCategoryListEvent) {
            switch event {
            case .clearSearchText:
                searchText.removeAll()
            case .sort:
                products = searchText.isEmpty
                ? originalProducts
                : originalProducts
                    .sorted(by: { $0.name.count < $1.name.count })
                    .filter {
                        $0.name.lowercased().contains(searchText.lowercased())
                    }
            case .addProduct(let product):
                if let index = originalProducts.firstIndex(of: product) {
                    originalProducts[index].isSelected.toggle()
                }
                if let index = products.firstIndex(of: product) {
                    products[index].isSelected.toggle()
                }
            }
        }

        func isFirstProduct(id: Int) -> Bool {
            id == products.first?.id ?? 0
        }

        func isLastProduct(id: Int) -> Bool {
            id == products.last?.id ?? 0
        }

        func isOneOnly() -> Bool {
            products.count == 1
        }
    }
}
