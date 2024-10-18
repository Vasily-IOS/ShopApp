//
//  ProductCellView.swift
//  ShopApp
//
//  Created by Василий on 10.10.2024.
//

import SwiftUI

struct ProductCellView: View {

    // MARK: - Properties

    var item: Item

    var body: some View {
        Text(item.name)
            .padding(.vertical, 3)
            .padding(.horizontal, 7)
            .background(makeCellColor())
            .cornerRadius(15)
            .foregroundColor(makeCellTextLabelColor())
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black, lineWidth: 0.5)
                    .hidden(item.color != "white")
            )

    }

    // MARK: - Instance methods

    private func makeCellColor() -> Color {
        switch item.color {
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
        switch item.color {
        case "white":
            return .black
        default:
            return .white
        }
    }
}
