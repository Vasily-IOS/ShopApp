//
//  FolderService.swift
//  ShopApp
//
//  Created by Василий on 17.09.2024.
//

// ЧТО ДОЛЖЕН ДЕЛАТЬ КЛАСС, ОТВЕЧАЮЩИЙ ЗА ПАПКИ
// 1. Загружать сохраненные папки из хранилища
// 2. Сохранять папку в хранилище
// 3. Удалять папку из хранилища

// ЧТО ДОЛЖЕН ДЕЛАТЬ КЛАСС, ОТВЕЧАЮЩИЙ ЗА СПИСКИ
// 1. Загружать сохраненные списки из хранилища по ключу
// 2. Сохранять список в указанную папку
// 3. Удалять список из папки
// 4. Добавлять выбранный спикок в избранное
// 5. Менять папку, в котором будет находиться список
// 6. Переименовывать список

// ВАЗИМОДЕЙСТВИЕ КЛАССОВ ПАПОК И СПИСКОВ
// 1. В КЛАССЕ ПАПОК ВСЕГДА БУДЕТ ОБНОВЛЯТЬСЯ СВОЙСТВО "selectedFolderID"
// 2. Также класс папок будет содержать класс списков
// 3. Класс списков автоматом будет обновлять списки в зависимости от выбранной папки

import SwiftUI

final class FolderService: ObservableObject {

    // MARK: - Properties

    private (set) var baseFolders = [
        FolderModel(id: 0, name: AssetString.all.rawValue),
        FolderModel(id: 1, name: AssetString.favourite.rawValue)
    ]

    @Published var foldersForSave: [FolderModel] = [] {
        didSet {
            updateFolderStorage(foldersForSave)
        }
    }

    @Published var selectedFolderID = 0

    // MARK: - Initializers

    init() {
        self.foldersForSave = loadSavedFolders()
    }

    // MARK: - Public methods

    func addFolder(name: String) {
        guard !(baseFolders + foldersForSave).contains(where: { $0.name == name }) else { return }

        let id = (foldersForSave.last?.id ?? 1) + 1
        print("Ай ди при добавлении \(id)")
        let folder = FolderModel(id: id, name: name)
        foldersForSave.append(folder)
    }

    func removeFolder(id: Int) {
        let index = foldersForSave.firstIndex(where: { $0.id == id }) ?? 2
        print("Индекс в массиве при удалении \(index)")
        foldersForSave.remove(at: index)
    }

    // MARK: - Private methods

    private func loadSavedFolders() -> [FolderModel] {
        if let data = UserDefaults.standard.data(forKey: StorageKey.savedFolders.rawValue),
           let arrayOfElements = try? JSONDecoder().decode([FolderModel].self, from: data) {
           return arrayOfElements
        }
        return []
    }

    private func updateFolderStorage(_ modelForSave: [FolderModel]) {
        if let data = try? JSONEncoder().encode(modelForSave) {
            UserDefaults.standard.set(data, forKey: StorageKey.savedFolders.rawValue)
        }
    }
}
