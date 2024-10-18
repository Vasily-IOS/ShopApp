//
//  CreateListViewModel.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import Foundation

extension CreateListView {
    @MainActor
    @Observable
    final class ViewModel {

        // MARK: - Properties

        var sortedCategories: [Category] = []

        var inputText: String = ""

        let itemListModel: ItemListModel

        // MARK: - Initializers

        init(itemListModel: ItemListModel) {
            self.itemListModel = itemListModel
        }

        // MARK: - Instance methods

        func sendEvent(_ event: CreateListEvent) {
            switch event {
            case .cleanInput:
                clearInput()
            case .sort(let text):
                sortProducts(by: text)
            }
        }

        // MARK: - Private methods

        private func clearInput() {
            inputText.removeAll()
            sortedCategories.removeAll()
        }

        private func sortProducts(by string: String) {
            let findTargetString = string.trimmingCharacters(in: .whitespaces)

            // все найденные айтемы
            let allFoundedItems = itemListModel.items.filter {
                $0.name.lowercased().contains(findTargetString.lowercased())
            }
            // доступные категории
            let categ = Array(Set(allFoundedItems.map { $0.category })).sorted()

            // кновертированная модель
            sortedCategories = categ.map { categoryID in
                Category(
                    id: categoryID,
                    name: "",
                    items: allFoundedItems.filter { $0.category == categoryID }
                )
            }
        }
    }
}
