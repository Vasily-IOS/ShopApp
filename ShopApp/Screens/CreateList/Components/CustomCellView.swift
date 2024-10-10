//
//  CustomCellView.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import SwiftUI

struct CustomCellView: View {

    // MARK: - Properties

    var item: Item

    var body: some View {
        Text(item.name)
            .padding(.vertical, 3)
            .padding(.horizontal, 7)
            .background(Color.mainBlue)
            .cornerRadius(15)
    }
}
