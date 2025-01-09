//
//  CreateListViewModel.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import Foundation
import Combine

extension CreateListView {
    @Observable
    final class ViewModel {

        // MARK: - Properties

        var searchText = ""

        var convertedAddedProducts: [(Int, [ProductUIModel])] = []

        var transitionProducts = PassthroughSubject<ProductUIModel, Never>()

        let productsListModel: ProductsListUIModel

        @ObservationIgnored private (set) var addedProducts: [ProductUIModel] = [] {
            didSet {
                makeReadableProducts(addedProducts)
            }
        }

        private (set) var sortedProducts: [ProductUIModel] = []

        private (set) var addedProductEvent = PassthroughSubject<AddedProductEvent, Never>()

        // MARK: - Initializers

        init(productsListModel: ProductsListUIModel) {
            self.productsListModel = productsListModel
        }

        // MARK: - Public methods

        func sendEvent(_ event: CreateListEvent) {
            switch event {
            case .cleanSearchText:
                cleanSearchText()
            case .sort:
                sortProducts()
            case .addProduct(let product):
                addProduct(product: product)
            case .addProductToolBar:
                addProductToolBar()
            }
        }

        func isFirstCategory(id: Int) -> Bool {
            id == productsListModel.productsCategory.first?.id ?? 0
        }

        func isLastCategory(id: Int) -> Bool {
            id == productsListModel.productsCategory.last?.id ?? 0
        }

        func makeCategory(id: Int) -> ProductCategoryUIModel {
            print("Maked category id: \(id)")
            let category = productsListModel.productsCategory.first(where: { $0.id == id })!
            let addedProducts = addedProducts.filter { $0.category == category.id }
            let newProducts = category.products.map { product in
                if addedProducts.contains(product) {
                    return ProductUIModel(id: product.id, category: product.category, name: product.name, isSelected: product.isSelected)
                }
                return product
            }.sorted(using: SortDescriptor(\.id))
            return ProductCategoryUIModel(
                id: category.id,
                name: category.name,
                products: newProducts
            )
        }

        // MARK: - Private methods

        private func isProductSelected(id: Int) -> Bool {
            addedProducts.contains(where: { $0.id == id })
        }

        private func makeReadableProducts(_ input: [ProductUIModel]) {
            convertedAddedProducts = Array(Dictionary(grouping: input) { $0.category }).sorted(by: { $0.key > $1.key })
        }

        private func cleanSearchText() {
            searchText.removeAll()
            sortedProducts.removeAll()
        }

        private func sortProducts() {
            let findTargetString = searchText.trimmingCharacters(in: .whitespaces)

            sortedProducts = productsListModel.allProducts
                .sorted(by: { $0.name.count < $1.name.count })
                .filter {
                    $0.name.lowercased().contains(findTargetString.lowercased())
                }
        }

        private func addProduct(product: ProductUIModel) {
            if !addedProducts.contains(where: { $0.name == product.name}) {
                addedProducts.append(product)
                searchText.removeAll()
            }
        }

        private func addProductToolBar() {
            let targetString = searchText.trimmingCharacters(in: .whitespaces)
            if productsListModel.allProducts.contains(where: { $0.name == targetString })
                && !addedProducts.contains(where: { $0.name == targetString }) {
                if let product = productsListModel.allProducts.first(where: { $0.name == targetString }) {
                    addedProducts.append(product)
                    searchText.removeAll()
                }
            } else {
                print("Надо добавить продукт в хранилище")
            }
        }
    }
}
