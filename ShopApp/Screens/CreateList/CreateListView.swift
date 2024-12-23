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

//    @State var products = [ProductUIModel]()

    var body: some View {
//        var productUIModelBindingWrapper = ProductUIModelBindingWrapper(bindingValue: $products)
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
                            viewModel.sendEvent(.cleanInput)
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

                AddedProductsView(products: $viewModel.convertedAddedProducts, addedProductEvent: viewModel.addedProductEvent)

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
                                .onTapGesture {
                                    router.push(.productCategoryList(category))
                                }
                        } else if viewModel.isLastCategory(id: category.id) {
                            CategoryCellView(categoryName: category.name)
                                .cornerRadius(15, corners: .init([.bottomLeft, .bottomRight]))
                                .onTapGesture {
                                    router.push(.productCategoryList(category))
                                }
                        } else {
                            CategoryCellView(categoryName: category.name)
                                .onTapGesture {
                                    router.push(.productCategoryList(category))
                                }
                        }
                    }
                }
            }
            .onChange(of: viewModel.searchText) { _, newValue in
                viewModel.sendEvent(.sort(text: newValue))
            }
            .screenSettings(isSettingsButtonHidden: false) {
                router.push(.settings)
            }
            .onReceive(viewModel.addedProductEvent) { event in
                switch event {
                case .navigateToSettings(let product):
                    router.present(.productDetail)
                case .selected(let product):
                    if let index = viewModel.addedProducts.firstIndex(of: product) {
                        viewModel.addedProducts[index].isSelected.toggle()
                    }
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }
}
