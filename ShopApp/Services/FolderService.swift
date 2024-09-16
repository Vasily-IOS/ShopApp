//
//  FolderService.swift
//  ShopApp
//
//  Created by Василий on 16.09.2024.
//

import Foundation

//@Observable
final class FolderService: ObservableObject {

    // MARK: - Properties

    @Published var folders: [FolderModel] = [] {
        didSet {
            updateFolderStorage(with: folders)
        }
    }

    // MARK: - Initializers

    init() {
        loadFolders()
    }

    // MARK: - Instance methods

    func loadFolders() {
        var baseFolders = [
            FolderModel(id: 0, name: AssetString.all.rawValue),
            FolderModel(id: 1, name: AssetString.favourite.rawValue)
        ]

        do {
            let savedFoldersData = UserDefaults.standard.data(forKey: StorageKey.savedFolders.rawValue) ?? Data()
            let savedFolders = try JSONDecoder().decode([FolderModel].self, from: savedFoldersData)
            baseFolders += savedFolders
        } catch {
            debugPrint(error)
        }

        folders = baseFolders // + берем из хранилища
    }

    func addFolder(_ folder: FolderModel) {
        folders.append(folder)
    }

    func removeFolder(_ indexForRemove: Int) {
        folders.remove(at: indexForRemove)
    }

    func updateFolderStorage(with folders: [FolderModel]) {
        do {
            let encodableModel = try JSONEncoder().encode(folders)
            UserDefaults.standard.setValue(encodableModel, forKey: StorageKey.savedFolders.rawValue)
        } catch {
            debugPrint(error)
        }
    }
}
