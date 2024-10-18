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

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(products) { product in
                    ProductCellView(product: product)
                        .padding(.all, 1)
                }
            }
        }
    }
}
