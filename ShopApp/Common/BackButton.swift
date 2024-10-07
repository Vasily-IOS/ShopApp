//
//  BackButton.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI

struct BackButtonView: View {

    // MARK: - Properties

    var backButtonTitle: LocalizedStringKey? = nil

    @Environment (\.colorScheme) var colorScheme

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    AssetImage.backArrow.image
                        .aspectRatio(contentMode: .fit)
                    Text(backButtonTitle ?? "")
                }
            }
            Spacer()
        }
    }
}

#Preview {
    BackButtonView()
}
