//
//  CategoryCellView.swift
//  ShopApp
//
//  Created by Василий on 07.12.2024.
//

import SwiftUI

struct CategoryCellView: View {

    // MARK: - Properties

    let categoryName: String

    var body: some View {
        LabeledContent(categoryName) {
            AssetImage.rightArrow.image
                .padding(.trailing, 16)
        }
        .font(.system(size: 20))
        .padding(.leading, 16)
        .frame(height: 44)
        .background(Color(uiColor: .mainBlue))
    }
}

#Preview {
    CategoryCellView(categoryName: "Молоко и сыр")
}
