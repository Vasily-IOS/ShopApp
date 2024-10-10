//
//  ItemsProvider.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import Foundation

enum ProductType: String {
    case healthAndBeauty = "healthAndBeauty" // красота и здоровье
    case petCareEssentials = "petCareEssentials" // зоотовары
    case workTools = "workTools" // рабочие инструменты
}

protocol ItemsProvider {
    var itemList: ItemListModel { get }
}

final class ItemsProviderImpl: ItemsProvider {

    // MARK: - Properties

    private (set) var itemList = ItemListModel()

    private let productTypes: [ProductType] = [
        .healthAndBeauty,
        .petCareEssentials,
        .workTools
    ]

    // MARK: - Initializers

    init() {
       generateItemsList()
    }

    // MARK: - Instance methods

    private func generateItemsList() {
        Task {
            let itemsCategories = await generateItemsCategories()
            let allItems = Array(itemsCategories.map({ $0.items }).joined())
            itemList = ItemListModel(items: allItems, itemsCategory: itemsCategories)
        }
    }

    private func generateItemsCategories() async -> [Items] {
        var result = [Items]()
        await withTaskGroup(of: Items.self) { group in
            for type in productTypes {
                group.addTask {
                    await self.decodeItem(by: type)!
                }
            }

            for await i in group {
                result.append(i)
            }
        }
        return result
    }

    private func decodeItem(by type: ProductType) async -> Items? {
        do {
            if let url = Bundle.main.url(forResource: type.rawValue, withExtension: "json") {
                let data = try Data(contentsOf: url)
                let products = try JSONDecoder().decode(Json.self, from: data)
                return products.data
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
