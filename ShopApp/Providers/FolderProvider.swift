//
//  FolderProvider.swift
//  ShopApp
//
//  Created by Василий on 06.10.2024.
//

import Foundation

protocol FolderProvider {
    func getBaseFolders() -> [FolderModel]
    func getSavedFolders() -> [FolderModel]
    func updateFolderStorage(_ modelForSave: [FolderModel])
}

final class FolderProviderImpl: FolderProvider {

    // MARK: - Properties

    private var baseFolders = [
        FolderModel(id: 0, name: AssetString.all.rawValue),
        FolderModel(id: 1, name: AssetString.favourite.rawValue)
    ]

    private var foldersForSave: [FolderModel] = []

    // MARK: - Initializers

    init() {
        foldersForSave = loadSavedFolders()
    }

    // MARK: - Instance methods

    func getBaseFolders() -> [FolderModel] {
        baseFolders
    }

    func getSavedFolders() -> [FolderModel] {
        loadSavedFolders()
    }

    func updateFolderStorage(_ modelForSave: [FolderModel]) {
        if let data = try? JSONEncoder().encode(modelForSave) {
            UserDefaults.standard.set(data, forKey: StorageKey.savedFolders.rawValue)
        }
    }

    private func loadSavedFolders() -> [FolderModel] {
        if let data = UserDefaults.standard.data(forKey: StorageKey.savedFolders.rawValue),
           let arrayOfElements = try? JSONDecoder().decode([FolderModel].self, from: data) {
            return arrayOfElements
        }
        return []
    }
}
