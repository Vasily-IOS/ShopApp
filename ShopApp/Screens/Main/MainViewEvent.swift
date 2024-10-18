//
//  MainViewEvent.swift
//  ShopApp
//
//  Created by Василий on 16.09.2024.
//

import Foundation

extension MainView.ViewModel {

    // MARK: - Nested types

    enum Event {
        case addFolder(String)
        case removeFolder(Int)
    }
}
