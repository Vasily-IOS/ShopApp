//
//  ProductCellView.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import SwiftUI

struct ProductPromptCellView: View {

    // MARK: - Properties

    var product: ProductModel

    var body: some View {
        Text(product.name)
            .padding(.vertical, 5)
            .padding(.horizontal, 10)
            .font(.system(size: 20))
            .background(Color(uiColor: .mainBlue))
            .cornerRadius(15)
            .foregroundColor(.black)
    }

    // MARK: - Instance methods

    private func makeCellColor() -> Color {
        switch product.color {
        case "systemTeal":
            return .teal
        case "pink":
            return .pink
        case "green":
            return .green
        case "orange":
            return .orange
        case "blue":
            return .blue
        case "red":
            return .red
        case "brown":
            return .brown
        case "blueWithOpacity":
            return .blue.opacity(0.7)
        case "cyan":
            return .cyan
        case "gray":
            return .gray
        default:
            return .white
        }
    }

    private func makeCellTextLabelColor() -> Color {
        switch product.color {
        case "white":
            return .black
        default:
            return .white
        }
    }
}
