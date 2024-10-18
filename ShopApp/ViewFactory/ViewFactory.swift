//
//  ViewFactory.swift
//  ShopApp
//
//  Created by Василий on 17.10.2024.
//

import SwiftUI

enum ViewFactory {
    case launchScreen
    case ondoarding
    case main
    case createList(ProductsListModel)
    case settings

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
            let itemsProvider: ProductsProvider = ItemsProviderImpl()
            let viewModel = MainView.ViewModel(folderProvider: folderProvider, itemsProvider: itemsProvider)
            MainView(viewModel: viewModel)
        case .createList(let productsListModel):
            let viewModel = CreateListView.ViewModel(productsListModel: productsListModel)
            CreateListView(viewModel: viewModel)
        case .settings:
            SettingsView()
        }
    }
}
