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

        @Published var folders: [FolderModel] = []

        @Published var selectedFolderID = 0

        private let folderService = FolderService()

        init() {
            folders = folderService.folders
        }

        // MARK: - Instance methods

        func sendEvent(_ event: Event) {
            switch event {
            case .addFolder(let folderName):
                let lastIndexOfFolders = folderService.folders.last?.id ?? 0
                let folder = FolderModel(id: lastIndexOfFolders + 1, name: folderName)

                folders.append(folder)
                folderService.addFolder(folder)

            case .removeFolder(let folderID):
                guard folderID > 1 else { return }

                let indexForRemove = folders.firstIndex(where: { $0.id == folderID }) ?? 0
                folders.remove(at: indexForRemove)
                folderService.removeFolder(indexForRemove)
                selectedFolderID = folders.last?.id ?? 0
            }
        }
    }
}
