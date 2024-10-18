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
    case createList(ItemListModel)
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
            let itemsProvider: ItemsProvider = ItemsProviderImpl()
            let viewModel = MainView.ViewModel(folderProvider: folderProvider, itemsProvider: itemsProvider)
            MainView(viewModel: viewModel)
        case .createList(let itemListModel):
            let viewModel = CreateListView.ViewModel(itemListModel: itemListModel)
            CreateListView(viewModel: viewModel)
        case .settings:
            SettingsView()
        }
    }
}
