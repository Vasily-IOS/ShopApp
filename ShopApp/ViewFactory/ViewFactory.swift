//
//  ViewFactory.swift
//  ShopApp
//
//  Created by Василий on 17.10.2024.
//

import SwiftUI
import Combine

enum ViewFactory {
    case launchScreen
    case ondoarding
    case main
    case createList(ProductsListUIModel)
    case settings
//    case productCategoryList(ProductCategoryUIModel)
    case productDetail

    @MainActor
    @ViewBuilder
    var view: some View {
        switch self {
        case .launchScreen:
            LaunchScreenView()
        case .ondoarding:
            let viewModel = OnboardingView.ViewModel()
            OnboardingView(viewModel: viewModel)
        case .main:
            let folderProvider: FolderProvider = FolderProviderImpl()
            let productsProvider: ProductsListUIProvider = ProductsListUIProviderImpl()
            let viewModel = MainView.ViewModel(folderProvider: folderProvider, productsProvider: productsProvider)
            MainView(viewModel: viewModel)
        case .createList(let productsListModel):
            let viewModel = CreateListView.ViewModel(productsListModel: productsListModel)
            CreateListView(viewModel: viewModel)
        case .settings:
            SettingsView()
//        case let .productCategoryList(productsCategory):
//            let viewModel = ProductsCategoryListView.ViewModel(productsCategory: productsCategory)
//            ProductsCategoryListView(viewModel: viewModel)
        case .productDetail:
            ProductDetailView()
        }
    }
}
