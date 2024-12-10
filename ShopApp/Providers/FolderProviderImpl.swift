//
//  FolderService.swift
//  ShopApp
//
//  Created by Василий on 07.12.2024.
//

import Foundation
import PersistedPropertyWrapper

extension UserDefaults {
    static let folders = UserDefaults(suiteName: "folders_storage")!
}

protocol FolderProvider {
    func fetchFolders() -> ([FolderModel], [FolderModel])
    func updateFolderStorage(_ modelForSave: [FolderModel])
}

final class FolderProviderImpl: FolderProvider {

    // MARK: - Properties

    private var baseFolders = [
        FolderModel(id: 0, name: AssetString.all.rawValue),
        FolderModel(id: 1, name: AssetString.favourite.rawValue)
    ]

    @Persisted(encodedDataKey: "savedFolders", storage: .folders) var savedFolders: [FolderModel]?

    // MARK: - Instance methods

    func fetchFolders() -> ([FolderModel], [FolderModel]) {
        (baseFolders, savedFolders ?? [])
    }

    func updateFolderStorage(_ savedFolders: [FolderModel]) {
        self.savedFolders = savedFolders
    }
}
