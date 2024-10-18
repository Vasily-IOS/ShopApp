//
//  OnboardingViewModel.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import Foundation

extension OnboardingView {
    @Observable
    @MainActor
    final class ViewModel {

        // MARK: - Properties

        var pageIndex = 0

        private (set) var pages = OnboardingModel.model

        // MARK: - Instance methods

        func isLastPage() -> Bool {
            pages.last?.tag == pageIndex
        }
    }
}
