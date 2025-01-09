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

protocol ProductsListUIProvider {
    var productList: ProductsListUIModel { get }
}

final class ProductsListUIProviderImpl: ProductsListUIProvider {

    // MARK: - Properties

    private (set) var productList = ProductsListUIModel()

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
        generateProductList()
    }

    // MARK: - Instance methods

    private func generateProductList() {
        Task {
            let itemsCategories = await generateItemsCategories()
            let allItems = Array(itemsCategories.map({ $0.products }).joined())
            productList = ProductsListUIModel(allProducts: allItems, productsCategory: itemsCategories)
        }
    }

    private func generateItemsCategories() async -> [ProductCategoryUIModel] {
        var result: [ProductCategoryUIModel] = []
        await withTaskGroup(of: ProductCategoryUIModel.self) { group in
            for type in productTypes {
                group.addTask {
                    await self.decodeCategoryItem(by: type)!
                }
            }

            for await i in group {
                result.append(i)
            }
        }
        return result.sorted(using: SortDescriptor(\.id))
    }

    private func decodeCategoryItem(by type: ProductType) async -> ProductCategoryUIModel? {
        do {
            if let url = Bundle.main.url(forResource: type.rawValue, withExtension: "json") {
                let data = try Data(contentsOf: url)
                let productsJson = try JSONDecoder().decode(ProductJsonModel.self, from: data)

                return ProductCategoryUIModel(
                    id: productsJson.data.id,
                    name: productsJson.data.name,
                    products: productsJson.data.products.map { ProductUIModel(
                        id: $0.id,
                        category: $0.category,
                        name: $0.name)
                    }
                )
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
}
