//
//  CategoryUIModel.swift
//  ShopApp
//
//  Created by Василий on 09.01.2025.
//

import Foundation

struct CategoryUIModel: Identifiable, Hashable {

    // MARK: - Nested types

    private enum Category: String {
        case fruits = "Овощи, фрукты и ягоды"
        case breadAndPastries = "Хлеб и выпечка"
        case milkAndCheese = "Молоко и сыр"
        case meatAndFish = "Мясо и рыба"
        case grainProducts = "Зерновые продукты"
        case frozenAndReadyToCook = "Заморозка и полуфабрикаты"
        case ingridientsAnfFlavforings = "Ингредиенты и специи"
        case sweetsAndSnacks = "Закуски и сладости"
        case drinks = "Напитки"
        case houseHoldEssentials = "Домашнее хозяйство"
        case healthAndBeauty = "Здоровье и красота"
        case petCareEssentials = "Зоотовары"
        case workTools = "Рабочие инструменты"

        init?(rawValue: Int) {
            switch rawValue {
            case 1:
                self = .fruits
            case 2:
                self = .breadAndPastries
            case 3:
                self = .milkAndCheese
            case 4:
                self = .meatAndFish
            case 5:
                self = .grainProducts
            case 6:
                self = .frozenAndReadyToCook
            case 7:
                self = .ingridientsAnfFlavforings
            case 8:
                self = .sweetsAndSnacks
            case 9:
                self = .drinks
            case 10:
                self = .houseHoldEssentials
            case 11:
                self = .healthAndBeauty
            case 12:
                self = .petCareEssentials
            case  13:
                self = .workTools
            default:
                return nil
            }
        }
    }

    // MARK: - Properties

    let id = UUID().uuidString
    let cat: Int
    let name: String
    let products: [ProductUIModel]

    // MARK: - Initializers

    init(cat: Int, products: [ProductUIModel]) {
        self.cat = cat
        self.name = Category(rawValue: cat)?.rawValue ?? ""
        self.products = products
    }
}
