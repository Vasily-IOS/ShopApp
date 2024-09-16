//
//  MainViewEvent.swift
//  ShopApp
//
//  Created by Василий on 16.09.2024.
//

import Foundation

typealias FolderName = String
typealias FolderID = Int

extension MainView.ViewModel {

    // MARK: - Nested types

    enum Event {
        case addFolder(FolderName)
        case removeFolder(FolderID)
    }
}
