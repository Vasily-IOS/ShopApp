//
//  ScreenSettings.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI

struct ScreenSettings: ViewModifier {

    // MARK: - Properties

    @Environment (\.colorScheme) var colorScheme

    var backButtonTitle: LocalizedStringKey

    var top: Double

    var bottom: Double

    var leading: Double

    var trailing: Double

    var isSettingsButtonHidden: Bool

    var onSettingsButtonTap: (() -> ())?

    var title: String

    var settingsButton: some View {
        Button {
            onSettingsButtonTap?()
        } label: {
            AssetImage.settings.image
        }
    }

    func body(content: Content) -> some View {
        content
            .padding(.init(top: top, leading: leading, bottom: bottom, trailing: trailing))
            .navigationBarBackButtonHidden()
            .navigationBarItems(
                leading: BackButtonView(backButtonTitle: backButtonTitle),
                trailing: settingsButton.hidden(isSettingsButtonHidden)
            )
            .navigationTitle(title)
    }
}

extension View {
    func screenSettings(
        backButtonTitle: LocalizedStringKey = "",
        top: Double = 25.0,
        bottom: Double = 25.0,
        leading: Double = 16.0,
        trailing: Double = 16.0,
        isSettingsButtonHidden: Bool = true,
        onSettingsButtonTap: (() -> ())? = nil,
        title: String = "Новый список"
    ) -> some View {
        modifier(
            ScreenSettings(
                backButtonTitle: backButtonTitle,
                top: top,
                bottom: bottom,
                leading: leading,
                trailing: trailing,
                isSettingsButtonHidden: isSettingsButtonHidden,
                onSettingsButtonTap: onSettingsButtonTap,
                title: title
            )
        )
    }
}

