//
//  MainViewModel.swift
//  ShopApp
//
//  Created by Василий on 16.09.2024.
//

import Foundation

extension MainView {
    @MainActor
    @Observable
    final class ViewModel {

        // MARK: - Properties

         var selectedFolderID = 0

         var isAlertPresented = false

         var baseFolders: [FolderModel] = []

         var foldersForSave: [FolderModel] = [] {
            didSet {
                folderProvider.updateFolderStorage(foldersForSave)
            }
        }

        var products: ProductsListModel {
            productsProvider.productList
        }

        private let folderProvider: FolderProvider

        private let productsProvider: ProductsProvider

        // MARK: - Initializers

        init(folderProvider: FolderProvider, itemsProvider: ProductsProvider) {
            self.folderProvider = folderProvider
            self.productsProvider = itemsProvider

            initializeFolders()
        }

        // MARK: - Instance methods

        func sendEvent(_ event: MainViewEvent) {
            switch event {
            case let .addFolder(name, completion):
                addFolder(name: name, completion: completion)
            case .removeFolder(let folderID):
                removeFolder(id: folderID)
            }
        }

        func isSelected(_ id: Int) -> Bool {
            id == selectedFolderID
        }

        func getItems() -> ProductsListModel {
            productsProvider.productList
        }

        // MARK: - Private methods

        private func initializeFolders() {
            let folders = folderProvider.fetchFolders()
            baseFolders = folders.0
            foldersForSave = folders.1
        }

        private func addFolder(name: String, completion: (() -> ())) {
            guard !(baseFolders + foldersForSave).contains(where: { $0.name == name }) else {
                completion()
                return
            }

            let id = (foldersForSave.last?.id ?? 1) + 1
            let folder = FolderModel(id: id, name: name)
            foldersForSave.append(folder)
        }

        private func removeFolder(id: Int) {
            if let folderIndex = foldersForSave.firstIndex(where: { $0.id == id }) {
                foldersForSave.remove(at: folderIndex)
                selectedFolderID = 0
            }
        }
    }
}
