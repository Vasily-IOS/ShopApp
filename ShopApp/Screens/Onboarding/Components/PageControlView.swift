//
//  PageControlView.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

struct PageControl: View {

    // MARK: - Properties

    var numberOfPages: Int

    @Binding var currentPage: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<numberOfPages, id: \.self) { page in
                Circle()
                    .fill(page == self.currentPage ? .orange : .orange.opacity(0.5))
                    .frame(width: 12, height: 12)
            }
        }
    }
}
