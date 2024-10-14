//
//  Extension + View.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI

extension View {

    // MARK: - Instance methods

    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }

    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
