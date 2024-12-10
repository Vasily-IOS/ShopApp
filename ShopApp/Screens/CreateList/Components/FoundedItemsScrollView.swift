//
//  FoundedItemsScrollView.swift
//  ShopApp
//
//  Created by Василий on 14.10.2024.
//

import SwiftUI

struct FoundedItemsScrollView: View {

    // MARK: - Properties

    var products: [ProductModel]

    var onProductSelected: ((ProductModel) -> ())

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(products) { product in
                    ProductPromptCellView(product: product)
                        .padding(.all, 1)
                        .onTapGesture {
                            onProductSelected(product)
                        }
                }
            }
        }
    }
}
