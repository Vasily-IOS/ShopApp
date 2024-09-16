//
//  OnboardingView.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

struct OnboardingView: View {

    // MARK: - Properties

    @AppStorage(StorageKey.isOnboardingShowed.rawValue) var isOnboardingShowed = false

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            PageControl(
                numberOfPages: viewModel.pages.count,
                currentPage: $viewModel.pageIndex
            )

            TabView(selection: $viewModel.pageIndex) {
                ForEach(viewModel.pages) { page in
                    OnboardingPageView(onboardingModel: page)
                        .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: viewModel.pageIndex)
            .tabViewStyle(.page(indexDisplayMode: .never))

            Button {
                if !viewModel.isLastPage() {
                    viewModel.pageIndex += 1
                } else {
                    isOnboardingShowed = true
                }
            } label: {
                HStack {
                    Spacer()
                    Text(baseButtonTitle)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    Spacer()
                }
                .frame(height: 56)
                .background(Color(uiColor: .orange))
                .cornerRadius(10)
            }
            .padding(.horizontal, 16)

            Button {
                isOnboardingShowed = true
            } label: {
                Text(skipButtonTitle)
                    .foregroundColor(viewModel.isLastPage() ? .clear : .gray)
            }
        }
        .padding(.vertical, 25)
    }

    // MARK: - Instance methods

    private var baseButtonTitle: String {
        viewModel.isLastPage() ? AssetString.begin.rawValue : AssetString.`continue`.rawValue
    }

    private var skipButtonTitle: String {
        viewModel.isLastPage() ? " " : AssetString.skip.rawValue
    }
}

#Preview {
    OnboardingView()
}
