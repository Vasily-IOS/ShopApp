//
//  AppRouter.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

final class AppRouter: ObservableObject {

    // MARK: - Instance methods

    enum Page: Identifiable, Hashable {
        case main

        var id: String {
            UUID().uuidString
        }
    }

    enum Sheet: Identifiable {
        case addItem(String, String, (String) -> ())

        var id: String {
            UUID().uuidString
        }
    }

    // MARK: - Properties

    @Published var path = NavigationPath()

    @Published var sheet: Sheet?

    // MARK: - Instance methods

    func push(_ page: Page) {
        self.path.append(page)
    }

    func present(_ sheet: Sheet) {
        self.sheet = sheet
    }

    func pop(count: Int = 1) {
        self.path.removeLast(count)
    }

    func popToRoot() {
        self.path.removeLast(path.count)
    }

    func dismissSheet() {
        self.sheet = nil
    }

    @ViewBuilder
    func build(_ page: Page) -> some View {
        switch page {
        case .main:
            MainView()
        }
    }

    @ViewBuilder
    func build(_ page: Sheet) -> some View {
        switch page {
        case let .addItem(title, placeholder, completion):
            AddListOrFolderView(
                title: title,
                placeholder: placeholder,
                completion: completion
            )
        }
    }
}
