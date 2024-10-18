//
//  CreateListView.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI

struct CreateListView: View {
    
    // MARK: - Properties

    @State var viewModel: ViewModel

    @EnvironmentObject var router: AppRouter
    
    var body: some View {
        VStack {
            HStack {
                AssetImage.search.image
                    .padding(.leading, 7)
                TextField(AssetString.enterItemName.rawValue, text: $viewModel.inputText)
                AssetImage.cross.image
                    .hidden(viewModel.inputText.isEmpty)
                    .onTapGesture {
                        viewModel.sendEvent(.cleanInput)
                    }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 36)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black.opacity(0.5))
            )
            
            VStack {
                ForEach(viewModel.sortedCategories) { category in
                    FoundedItemsScrollView(items: category.items)
                }
                Spacer()
            }
        }
        .onChange(of: viewModel.inputText) { _, newValue in
            viewModel.sendEvent(.sort(text: newValue))
        }
        .screenSettings(isSettingsButtonHidden: false) {
            router.push(.settings)
        }
    }
}
