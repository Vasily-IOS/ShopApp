//
//  MainViewModel.swift
//  ShopApp
//
//  Created by Василий on 16.09.2024.
//

import Foundation

extension MainView {
    @MainActor
    final class ViewModel: ObservableObject {

        // MARK: - Properties

        @Published var selectedFolderID = 0

        @Published var baseFolders: [FolderModel] = []

        @Published var foldersForSave: [FolderModel] = [] {
            didSet {
                folderProvider.updateFolderStorage(foldersForSave)
            }
        }

        private let folderProvider: FolderProvider = FolderProviderImpl()

        // MARK: - Initializers

        init() {
            baseFolders = folderProvider.getBaseFolders()
            foldersForSave = folderProvider.getSavedFolders()
        }

        // MARK: - Instance methods

        func addFolder(name: String) {
            guard (baseFolders + foldersForSave).contains(where: { $0.name == name }) else { return }

            let id = (foldersForSave.last?.id ?? 1) + 1
            let folder = FolderModel(id: id, name: name)
            foldersForSave.append(folder)
        }

        func isSelected(_ id: Int) -> Bool {
            id == selectedFolderID
        }
    }
}
