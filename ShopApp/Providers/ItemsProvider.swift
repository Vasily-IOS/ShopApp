//
//  ItemsProvider.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import Foundation

protocol ItemsProvider {
    var items: [Item] { get }
}

final class ItemsProviderImpl: ItemsProvider {

    // MARK: - Properties

    private (set) var items: [Item] = []

    // MARK: - Initializers

    init() {
        Task {
            items = await getItems()
        }
    }

    // MARK: - Instance methods

    private func getItems() async -> [Item] {
        do {
            if let url = Bundle.main.url(forResource: "workTools", withExtension: "json") {
                let data = try Data(contentsOf: url)
                let products = try JSONDecoder().decode(Json.self, from: data)
                return products.data.items
            } else {
                return []
            }
        } catch {
            return []
        }
    }
}
