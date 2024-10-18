//
//  ProductChapterCellView.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import SwiftUI

struct ProductChapterCellView: View {

    // MARK: - Properties

    var categoryName: String

    var body: some View {
        HStack {
            Text(categoryName)
                .font(.system(size: 24, weight: .light))
                .padding(.leading, 16)
            Spacer()
        }
        .frame(height: 44)
        .background(Color.mainBlue)
    }
}

#Preview {
    ProductChapterCellView(categoryName: "jjdjjd")
}
