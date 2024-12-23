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

    @State private var isSelected = false

    var body: some View {
        HStack {
            (product.isSelected ? AssetImage.productSelected.image : AssetImage.productSelect.image)
                .onTapGesture {
                    addedProductEvent.send(.selected(product))
                }
            Text(product.name)
                .font(.system(size: 20))
                .background {
                    Rectangle()
                        .frame(height: 1)
                        .hidden(!product.isSelected)
                }
            Spacer()
            AssetImage.cardMenu.image
                .padding(.trailing, 16)
                .onTapGesture {
                    addedProductEvent.send(.navigateToSettings(product))
                }
        }
        .padding(.leading, 16)
        .frame(height: 44)
        .background(product.isSelected ? .orange.opacity(0.5) : .orange)
        .onLongPressGesture {
            addedProductEvent.send(.selected(product))
            isSelected.toggle()
        }
//        .sensoryFeedback(.success, trigger: isSelected) { _, newValue in
//            return newValue
//        }
    }
}
