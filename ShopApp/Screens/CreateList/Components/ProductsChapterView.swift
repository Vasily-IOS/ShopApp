//
//  ProductsChapterView.swift
//  ShopApp
//
//  Created by Василий on 15.12.2024.
//

import SwiftUI

struct ProductsChapterView: View {

    // MARK: - Properties

    let cat: Cat

    var body: some View {
        LabeledContent(cat.name, value: "")
            .foregroundStyle(.gray)
            .font(.system(size: 16))
        VStack(spacing: 3) {
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
}
