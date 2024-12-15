//
//  ProductCellView.swift
//  ShopApp
//
//  Created by Василий on 10.12.2024.
//

import SwiftUI

struct ProductCellView: View {

    // MARK: - Properties

    let product: ProductModel

    var body: some View {
        HStack {
            AssetImage.productSelect.image
            Text(product.name)
                .padding(.trailing, 16)
            Spacer()
            AssetImage.cardMenu.image
                .padding(.trailing, 16)
        }
        .font(.system(size: 20))
        .padding(.leading, 16)
        .frame(height: 44)
        .background(.orange)
    }
}

#Preview {
    ProductCellView(product: ProductModel(id: 0, category: 1, color: "red", name: "Cheese"))
}
