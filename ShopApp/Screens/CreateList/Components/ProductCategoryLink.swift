//
//  ProductCategoryLink.swift
//  ShopApp
//
//  Created by Василий on 03.01.2025.
//

import SwiftUI

struct ProductCategoryLink<T: View>: View {

    // MARK: - Properties

    let name: String

    let destinationV: T

    var body: some View {
        NavigationLink(destination: destinationV) {
            LabeledContent(name) {
                AssetImage.rightArrow.image
                    .padding(.trailing, 16)
            }
            .font(.system(size: 20))
            .padding(.leading, 16)
            .frame(height: 44)
            .background(Color(uiColor: .mainBlue))
            .foregroundStyle(.black)
        }
    }
}
