//
//  AddedProductsView.swift
//  ShopApp
//
//  Created by Василий on 07.12.2024.
//

import SwiftUI

enum Category: String {
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

struct Cat: Identifiable {
    let id = UUID().uuidString
    let cat: Int
    let name: String
    let products: [ProductModel]

    init(cat: Int, products: [ProductModel]) {
        self.cat = cat
        self.name = Category(rawValue: cat)?.rawValue ?? ""
        self.products = products
    }
}

struct AddedProductsView: View {

    // MARK: - Properties

    @Binding var products: [(Int, [ProductModel])]

    var body: some View {
        VStack(spacing: 3) {
            ForEach(products.map { Cat(cat: $0.0, products: $0.1) }) { cat in
                ProductChapter(cat: cat)
            }
        }
    }
}

struct ProductChapter: View {

    // MARK: - Properties

    let cat: Cat

    var body: some View {
        LabeledContent(cat.name, value: "")
            .foregroundStyle(.gray)
            .font(.system(size: 16))
        ForEach(cat.products) { product in
            if cat.products.count == 1 {
                ProductCellView(product: product)
                    .cornerRadius(15, corners: .allCorners)
            } else {
                if product.id == cat.products.first?.id {
                    ProductCellView(product: product)
                        .cornerRadius(15, corners: [.topLeft, .topRight])
                } else if product.id == cat.products.last?.id {
                    ProductCellView(product: product)
                        .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                } else {
                    ProductCellView(product: product)
                }
            }
        }
    }
}
