//
//  ProductsCategoryListView.swift
//  ShopApp
//
//  Created by Василий on 15.12.2024.
//

import SwiftUI
import Combine

struct ProductsCategoryListView: View {

    // MARK: - Properties

    @State var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                HStack {
                    AssetImage.search.image
                        .padding(.leading, 7)
                    TextField(AssetString.enterItemName.rawValue, text: $viewModel.searchText)
                        .onChange(of: viewModel.searchText) {
                            viewModel.sendEvent(.sort)
                        }
                    AssetImage.cross.image
                        .hidden(viewModel.searchText.isEmpty)
                        .onTapGesture {
                            viewModel.sendEvent(.clearSearchText)
                        }
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 46)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black.opacity(0.5))
                )
                .padding(.top, 0)

                VStack(spacing: 3) {
                    ForEach(viewModel.products) { product in
                        if viewModel.isFirstProduct(id: product.id) && !viewModel.isOneOnly() {
                            ProductCategoryCell(product: product)
                                .cornerRadius(15, corners: .init([.topLeft, .topRight]))
                                .onTapGesture {
                                    viewModel.sendEvent(.addProduct(product))
                                }
                        } else if viewModel.isLastProduct(id: product.id) && !viewModel.isOneOnly() {
                            ProductCategoryCell(product: product)
                                .cornerRadius(15, corners: .init([.bottomLeft, .bottomRight]))
                                .onTapGesture {
                                    viewModel.sendEvent(.addProduct(product))
                                }
                        } else if viewModel.isOneOnly() {
                            ProductCategoryCell(product: product)
                                .cornerRadius(15, corners: .allCorners)
                                .onTapGesture {
                                    viewModel.sendEvent(.addProduct(product))
                                }
                        } else {
                            ProductCategoryCell(product: product)
                                .onTapGesture {
                                    viewModel.sendEvent(.addProduct(product))
                                }
                        }
                    }
                }
                .padding(.top, 10)
            }
            .screenSettings(title: viewModel.listDescription)
        }
        .scrollDismissesKeyboard(.immediately)
    }
}
