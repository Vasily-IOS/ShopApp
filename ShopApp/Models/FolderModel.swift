//
//  FolderModel.swift
//  ShopApp
//
//  Created by Василий on 16.09.2024.
//

import Foundation
import PersistedPropertyWrapper

struct FolderModel: Codable, Identifiable, Equatable, UserDefaultsPrimitive {
    let id: Int
    let name: String
}
