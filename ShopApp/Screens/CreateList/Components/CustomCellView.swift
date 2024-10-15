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
            .background(makeCellColor())
            .cornerRadius(15)
            .foregroundColor(.white)
    }

    // MARK: - Instance methods

    private func makeCellColor() -> Color {
        switch item.color {
        case "systemTeal": // 11
            return .teal
        case "pink": // 12
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
        default: // default
            return .white
        }
    }
}
