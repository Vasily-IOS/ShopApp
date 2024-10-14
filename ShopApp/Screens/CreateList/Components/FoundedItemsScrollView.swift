//
//  FoundedItemsScrollView.swift
//  ShopApp
//
//  Created by Василий on 14.10.2024.
//

import SwiftUI

struct FoundedItemsScrollView: View {

    // MARK: - Properties

    var items: [Item]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(items, id: \.self) { item in
                    CustomCellView(item: item)
                }
            }
        }
    }
}
