//
//  MainViewEvent.swift
//  ShopApp
//
//  Created by Василий on 16.09.2024.
//

import Foundation

enum MainViewEvent {
    case addFolder(String, (() -> ()))
    case removeFolder(Int)
}
