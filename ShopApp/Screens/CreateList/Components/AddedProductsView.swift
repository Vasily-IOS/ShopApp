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

struct AddedProductsView: View {

    // MARK: - Properties

    @Binding var products: [ProductModel]

    var body: some View {
        VStack(spacing: 3) {
            ForEach(0..<Array(Set(products.map { $0.category })).count, id: \.self) { cat in
                Section(Category.init(rawValue: cat)?.rawValue ?? "Нет ззачения") {
                    List(products.filter { $0.category == cat }) { element in
                        ProductCellView(product: element)
                    }
                }
            }
//            ForEach(products) { product in
//                if products.count == 1 {
//                    ProductCellView(product: product)
//                        .cornerRadius(15, corners: .allCorners)
//                } else {
//                    if product.id == products.first?.id {
//                        ProductCellView(product: product)
//                            .cornerRadius(15, corners: [.topLeft, .topRight])
//                    } else if product.id == products.last?.id {
//                        ProductCellView(product: product)
//                            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
//                    } else {
//                        ProductCellView(product: product)
//                    }
//                }
//            }
        }
    }
}

#Preview {
    AddedProductsView(products: .constant([
        .init(id: 0, category: 0, color: "red", name: "Земляника"),
        .init(id: 5, category: 0, color: "red", name: "Малина"),
        .init(id: 1, category: 1, color: "blue", name: "Черный хлеб"),
        .init(id: 2, category: 2, color: "orange", name: "Сливки"),
        .init(id: 3, category: 3, color: "yellow", name: "Карась")
    ]))
}

//            ForEach(0..<Array(Set(products.map { $0.category })).count, id: \.self) { categoryID in
//                LabeledContent(Category.init(rawValue: categoryID)?.rawValue ?? "", value: "")
//                    .font(.system(size: 16))
//                    .foregroundStyle(.gray)
//                VStack(spacing: 3) {
//                    ForEach(self.products.filter { $0.category == categoryID }) { pr in
//                        LabeledContent(pr.name, value: "")
//                            .font(.system(size: 20))
//                            .padding(.leading, 16)
//                            .frame(height: 44)
//                            .background(.orange)
//                    }
//                }
//            }
