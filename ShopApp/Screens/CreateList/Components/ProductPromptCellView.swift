//
//  ProductCellView.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import SwiftUI

struct ProductPromptCellView: View {

    // MARK: - Properties

    var product: ProductUIModel

    var body: some View {
        Text(product.name)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .font(.system(size: 20))
            .background(Color(uiColor: .mainBlue))
            .cornerRadius(15)
            .foregroundColor(.black)
    }
}
