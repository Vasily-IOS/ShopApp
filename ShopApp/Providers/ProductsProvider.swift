//
//  ItemsProvider.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import Foundation

enum ProductType: String {
    case vegetablesFruitsAndBerries = "vegetablesFruitsAndBerries" // 1. Фрукты и овощи
    case breadAndPastries = "breadAndPastries" // 2. Хлеб и выпечка
    case milkAndCheese = "milkAndCheese" // 3. Молоко и сыр
    case meatAndFish = "meatAndFish" // 4. Мясо и рыба
    case grainProducts = "grainProducts" // 5. Зерновые продукты
    case frozenAndReadyToCookProduct = "frozenAndReadyToCookProduct" // 6. Заморозка и полуфабрикаты
    case ingredientsAndFlavorings = "ingredientsAndFlavorings" // 7. Ингредиенты и специи
    case snacksAndSweets = "snacksAndSweets" // 8. Закуски и сладости
    case beverageAssortment = "beverageAssortment" // 9. Напитки
    case healthAndBeauty = "healthAndBeauty" // красота и здоровье
    case petCareEssentials = "petCareEssentials" // зоотовары
    case workTools = "workTools" // рабочие инструменты
    case householdEssentials = "householdEssentials" // домашнее хозяйство
}

protocol ProductsProvider {
    var productList: ProductsListModel { get }
}

final class ItemsProviderImpl: ProductsProvider {

    // MARK: - Properties

    private (set) var productList = ProductsListModel()

    private let productTypes: [ProductType] = [
        .vegetablesFruitsAndBerries,
        .breadAndPastries,
        .milkAndCheese,
        .meatAndFish,
        .grainProducts,
        .frozenAndReadyToCookProduct,
        .ingredientsAndFlavorings,
        .snacksAndSweets,
        .beverageAssortment,
        .householdEssentials,
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
            let allItems = Array(itemsCategories.map({ $0.products }).joined())
            productList = ProductsListModel(allProducts: allItems, productsCategory: itemsCategories)
        }
    }

    private func generateItemsCategories() async -> [ProductCategoryModel] {
        var result = [ProductCategoryModel]()
        await withTaskGroup(of: ProductCategoryModel.self) { group in
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

    private func decodeItem(by type: ProductType) async -> ProductCategoryModel? {
        do {
            if let url = Bundle.main.url(forResource: type.rawValue, withExtension: "json") {
                let data = try Data(contentsOf: url)
                let products = try JSONDecoder().decode(ProductJsonModel.self, from: data)
                return products.data
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
