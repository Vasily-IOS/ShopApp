//
//  AddedProductsView.swift
//  ShopApp
//
//  Created by Василий on 07.12.2024.
//

import SwiftUI
import Combine

enum AddedProductEvent {
    case selected(ProductUIModel)
    case navigateToSettings(ProductUIModel)
    case removeProduct(ProductUIModel)
}

struct AddedProductsView: View {

    // MARK: - Properties

    var addedProductEvent: PassthroughSubject<AddedProductEvent, Never>

    @Binding var products: [(Int, [ProductUIModel])]

    @State private var offset = 0.0

    @State private var selectedCell: Int?

    var body: some View {
        VStack(spacing: 10) {
            ForEach(products.map { CategoryUIModel(cat: $0.0, products: $0.1) }, id: \.name) { category in
                LabeledContent(category.name, value: "")
                    .foregroundStyle(.gray)
                    .font(.system(size: 16))
                VStack(spacing: 3) {
                    ForEach(category.products, id: \.self) { product in
                        ProductCellView(
                            addedProductEvent: addedProductEvent,
                            product: product
                        )
                        .offset(x: (selectedCell ?? 0) == product.id ? offset : 0)
                        .cornerRadius(15, corners: makeCorners(category: category, product: product))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    if 0 > value.translation.width {
                                        selectedCell = product.id
                                        offset = value.translation.width
                                    }
                                }
                                .onEnded { value in
                                    if value.translation.width < -100 {
                                        withAnimation {
                                            offset = 0.0
                                            addedProductEvent.send(.removeProduct(product))
                                            selectedCell = nil
                                        }
                                    } else {
                                        withAnimation {
                                            offset = 0.0
                                            selectedCell = nil
                                        }
                                    }
                                }
                        )
                    }
                }
            }
        }
    }

    // MARK: - Instance methods

    private func makeCorners(category: CategoryUIModel, product: ProductUIModel) -> UIRectCorner {
        if category.products.count == 1 {
            return .allCorners
        } else {
            if product.id == category.products.first?.id {
                return [.topLeft, .topRight]
            } else if product.id == category.products.last?.id {
                return [.bottomLeft, .bottomRight]
            } else {
                return []
            }
        }
    }
}
