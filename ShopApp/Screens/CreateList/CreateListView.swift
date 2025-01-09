//
//  CreateListView.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI
import Combine

enum AddedProductEvent {
    case selected(ProductUIModel)
    case navigateToSettings(ProductUIModel)
}

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
                    TextField(AssetString.enterItemName.rawValue, text: $viewModel.searchText)
                        .toolbar {
                            if !viewModel.searchText.isEmpty {
                                ToolbarItemGroup(placement: .keyboard) {
                                    HStack {
                                        Spacer()
                                        Button("Добавить") {
                                            viewModel.sendEvent(.addProductToolBar)
                                        }
                                    }
                                }
                            }
                        }
                    AssetImage.cross.image
                        .hidden(viewModel.searchText.isEmpty)
                        .onTapGesture {
                            viewModel.sendEvent(.cleanSearchText)
                        }
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 46)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(.black.opacity(0.5))
                )
                .padding(.top, 0)

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

                AddedProductsView(
                    products: $viewModel.convertedAddedProducts,
                    addedProductEvent: viewModel.addedProductEvent
                )

                if !viewModel.addedProducts.isEmpty {
                    Color.black
                        .frame(height: 1)
                        .padding(.vertical, 17)
                }

                VStack(spacing: 3) {
                    ForEach(viewModel.productsListModel.productsCategory) { category in
                        if viewModel.isFirstCategory(id: category.id) {
                            ProductCategoryLink(
                                name: category.name,
                                destinationV: ProductsCategoryListView(
                                    viewModel: ProductsCategoryListView.ViewModel(
                                        productsCategory: viewModel.makeCategory(id: category.id)
                                    ),
                                    transitionProducts: viewModel.transitionProducts
                                )
                            )
                            .cornerRadius(15, corners: .init([.topLeft, .topRight]))
                        } else if viewModel.isLastCategory(id: category.id) {
                            ProductCategoryLink(
                                name: category.name,
                                destinationV: ProductsCategoryListView(
                                    viewModel: ProductsCategoryListView.ViewModel(
                                        productsCategory: viewModel.makeCategory(id: category.id)
                                    ),
                                    transitionProducts: viewModel.transitionProducts
                                )
                            )
                            .cornerRadius(15, corners: .init([.bottomLeft, .bottomRight]))
                        } else {
                            ProductCategoryLink(
                                name: category.name,
                                destinationV: ProductsCategoryListView(
                                    viewModel: ProductsCategoryListView.ViewModel(
                                        productsCategory: viewModel.makeCategory(id: category.id)
                                    ),
                                    transitionProducts: viewModel.transitionProducts
                                )
                            )
                        }
                    }
                }
            }
            .onChange(of: viewModel.searchText) {
                viewModel.sendEvent(.sort)
            }
            .screenSettings(isSettingsButtonHidden: false) {
                router.push(.settings)
            }
            .onReceive(viewModel.addedProductEvent) { event in
                switch event {
                case .navigateToSettings(_): // let product
                    router.present(.productDetail)
                case .selected(let product):
                    print("Select product: \(product.name)")
//                    if let index = viewModel.addedProducts.firstIndex(of: product) {
//                        viewModel.addedProducts[index].isSelected.toggle()
//                    }
                }
            }
            .onReceive(viewModel.transitionProducts) { product in
                print("Should add product from product category: \(product.name)")
//                viewModel.sendEvent(.addProduct(product))
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }
}
