//
//  CreateListView.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI
import Combine

struct CreateListView: View {

    // MARK: - Properties

    @State var viewModel: ViewModel

    @EnvironmentObject var router: AppRouter

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                // 1. Текстовый ввод для поиска товаров/продуктов
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

                // 2. Скролл с найденными товарами
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

                // 3. Вьюха с добавленными товарами
                AddedProductsView(
                    addedProductEvent: viewModel.addedProductEvent,
                    products: $viewModel.convertedAddedProducts
                )

                // 4. Разделитель, который появляется, если список добавленных товаров не пуст
                if !viewModel.addedProducts.isEmpty {
                    Color.black
                        .frame(height: 1)
                        .padding(.vertical, 17)
                }

                // 5. Список категорий
                VStack(spacing: 3) {
                    ForEach(viewModel.productsListModel.productsCategory) { category in
                        ProductCategoryLink(name: category.name, destinationV: ProductsCategoryListView(viewModel: ProductsCategoryListView.ViewModel(productsCategory: category)))
                            .cornerRadius(15, corners: makeCorners(id: category.id))
                    }
                }
            }
            .screenSettings(isSettingsButtonHidden: false) {
                router.push(.settings)
            }
            .onChange(of: viewModel.searchText) {
                viewModel.sendEvent(.sort)
            }
            .onReceive(viewModel.addedProductEvent) { event in
                switch event {
                case .navigateToSettings(_): // let product
                    router.present(.productDetail)
                case .selected(let product):
                    viewModel.sendEvent(.toggleProductSelection(product))
                case .removeProduct(let product):
                    viewModel.sendEvent(.removeProduct(product))
                }
            }
        }
        .scrollDismissesKeyboard(.immediately)
    }

    // MARK: - Instance methods

    private func makeCorners(id: Int) -> UIRectCorner {
        if id == viewModel.productsListModel.productsCategory.first?.id ?? 0 {
            return [.topLeft, .topRight]
        } else if id == viewModel.productsListModel.productsCategory.last?.id ?? 0 {
            return [.bottomLeft, .bottomRight]
        } else {
            return []
        }
    }
}
