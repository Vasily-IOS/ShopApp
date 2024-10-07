//
//  AssetImage.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

enum AssetImage {
    case launchScreen
    case onboardingOne
    case onboardingTwo
    case onboardingThree
    case addFolder
    case backArrow
    case settings
    case search

    var image: Image {
        switch self {
        case .launchScreen:
            return Image("launchScreen_icon")
        case .onboardingOne:
            return Image("onboardingOne_icon")
        case .onboardingTwo:
            return Image("onboardongTwo_icon")
        case .onboardingThree:
            return Image("onboardingThree_icon")
        case .addFolder:
            return Image("addFolder_icon")
        case .backArrow:
            return Image("backArrow_icon")
        case .settings:
            return Image("settings_icon")
        case .search:
            return Image("search_icon")
        }
    }
}
