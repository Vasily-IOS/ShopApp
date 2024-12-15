//
//  ProductCategoryCell.swift
//  ShopApp
//
//  Created by Василий on 15.12.2024.
//

import SwiftUI

struct ProductCategoryCell: View {

    // MARK: - Properties

    let product: ProductModel

    var body: some View {
        LabeledContent(product.name, value: "")
            .font(.system(size: 20))
            .padding(.leading, 16)
            .frame(height: 44)
            .background(Color(uiColor: .mainBlue))
    }
}
