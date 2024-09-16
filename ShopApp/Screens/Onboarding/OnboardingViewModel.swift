//
//  OnboardingViewModel.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import Foundation

extension OnboardingView {
    @MainActor
    final class ViewModel: ObservableObject {

        // MARK: - Properties

        private (set) var pages = OnboardingModel.model

        @Published var pageIndex = 0

        // MARK: - Instance methods

        func isLastPage() -> Bool {
            pages.last?.tag == pageIndex
        }
    }
}
