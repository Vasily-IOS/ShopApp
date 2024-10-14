//
//  CreateListViewModel.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import Foundation

extension CreateListView {
    @MainActor
    final class ViewModel: ObservableObject {

        // MARK: - Properties

        @Published var sortedCategories: [Category] = []

        @Published var inputText: String = ""

        // MARK: - Instance methods

        func clearInput() {
            inputText = ""
            sortedCategories = []
        }
    }
}
