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
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
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
                .frame(maxWidth: .infinity, minHeight: 46)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black.opacity(0.5))
                )

                if !viewModel.sortedProducts.isEmpty {
                    HStack {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(viewModel.sortedProducts, id: \.self) { product in
                                    ProductPromptCellView(product: product)
                                        .onTapGesture {
                                            viewModel.sendEvent(.addProduct(product))
                                        }
                                }
                            }
                        }
                    }
                    .padding(.vertical, 6)
                }

                AddedProductsView(products: $viewModel.convertedAddedProducts)

                if !viewModel.addedProducts.isEmpty {
                    Color.black
                        .frame(height: 1)
                        .padding(.vertical, 17)
                }

                VStack(spacing: 3) {
                    ForEach(viewModel.productsListModel.productsCategory) { category in
                        if viewModel.isFirstCategory(id: category.id) {
                            CategoryCellView(categoryName: category.name)
                                .cornerRadius(15, corners: .init([.topLeft, .topRight]))
                        } else if viewModel.isLastCategory(id: category.id) {
                            CategoryCellView(categoryName: category.name)
                                .cornerRadius(15, corners: .init([.bottomLeft, .bottomRight]))
                        } else {
                            CategoryCellView(categoryName: category.name)
                        }
                    }
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
}
