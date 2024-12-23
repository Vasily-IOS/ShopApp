//
//  ProductCellView.swift
//  ShopApp
//
//  Created by Василий on 10.12.2024.
//

import SwiftUI
import Combine

struct ProductCellView: View {

    // MARK: - Properties

    let product: ProductUIModel

    var addedProductEvent: PassthroughSubject<AddedProductEvent, Never>

    var body: some View {
        HStack {
            AssetImage.productSelect.image
                .onTapGesture {
                    addedProductEvent.send(.selected)
                }
            Text(product.name)
                .padding(.trailing, 16)
                .font(.system(size: 20))
            Spacer()
            AssetImage.cardMenu.image
                .padding(.trailing, 16)
                .onTapGesture {
                    addedProductEvent.send(.navigateToSettings)
                }
        }
        .padding(.leading, 16)
        .frame(height: 44)
        .background(.orange)
    }
}
