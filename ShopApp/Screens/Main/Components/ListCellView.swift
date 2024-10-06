//
//  ListCellView.swift
//  ShopApp
//
//  Created by Василий on 07.10.2024.
//

import SwiftUI

struct ListCellView: View {

    var item: Int

    var body: some View {
        HStack {
            Spacer()
            Text("\(item)")
            Spacer()
        }
        .frame(height: 200)
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.white)
                .shadow(color: .gray.opacity(0.65), radius: 1, x: 0, y: 0)
        )
        .padding(.horizontal, 1)

    }
}
