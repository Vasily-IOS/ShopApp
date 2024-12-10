//
//  CreateListViewModel.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import Foundation

extension CreateListView {
    @Observable
    final class ViewModel {

        // MARK: - Properties

        var sortedProducts: [ProductModel] = []

        var addedProducts: [ProductModel] = []

        var inputText: String = ""

        let productsListModel: ProductsListModel

        // MARK: - Initializers

        init(productsListModel: ProductsListModel) {
            self.productsListModel = productsListModel
        }

        // MARK: - Public methods

        func sendEvent(_ event: CreateListEvent) {
            switch event {
            case .cleanInput:
                clearInput()
            case .sort(let text):
                sortProducts(by: text)
            case .addProduct(let product):
                addProduct(product: product)
            }
        }

        func isFirstCategory(id: Int) -> Bool {
            id == productsListModel.productsCategory.first?.id ?? 0
        }

        func isLastCategory(id: Int) -> Bool {
            id == productsListModel.productsCategory.last?.id ?? 0
        }

        // MARK: - Private methods

        private func clearInput() {
            inputText.removeAll()
            sortedProducts.removeAll()
        }

        private func sortProducts(by string: String) {
            let findTargetString = string.trimmingCharacters(in: .whitespaces)
            sortedProducts = productsListModel.allProducts.filter {
                $0.name.lowercased().contains(findTargetString.lowercased())
            }
        }

        private func addProduct(product: ProductModel) {
            if !addedProducts.contains(where: { $0.name == product.name}) {
                addedProducts.append(product)
                print("Added product \(product.name)")
            }
        }
    }
}
