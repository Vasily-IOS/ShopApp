//
//  CreateListView.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI

struct CreateListView: View {

    // MARK: - Properties

    @State var inputText = ""

    var body: some View {
        VStack {
            HStack {
                AssetImage.search.image
                    .padding(.leading, 7)

                TextField("Введите название товара", text: $inputText)
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 36)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black.opacity(0.5))
            )
            Spacer()
        }
        .screenSettings(isSettingsButtonHidden: false) {
            print("Go to settings")
        }
    }
}

#Preview {
    CreateListView()
}
