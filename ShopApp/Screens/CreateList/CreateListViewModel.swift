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

        func clearInput() {
            inputText = ""
            sortedCategories = []
        }
    }
}
