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
            .padding(.top)

            TabView(selection: $viewModel.pageIndex) {
                ForEach(viewModel.pages) { page in
                    VStack {
                        Spacer()
                        OnboardingPageView(onboardingModel: page)
                        Spacer()

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
                        .padding(.top, 5)

                        Spacer()
                    }
                    .tag(page.tag)
                }
            }
            .animation(.easeInOut, value: viewModel.pageIndex)
            .tabViewStyle(.page(indexDisplayMode: .never))
        }
    }

    // MARK: - Instance methods

    private var baseButtonTitle: String {
        viewModel.isLastPage() ? AssetString.begin.rawValue : AssetString.`continue`.rawValue
    }

    private var skipButtonTitle: String {
        viewModel.isLastPage() ? "" : AssetString.skip.rawValue
    }
}

#Preview {
    OnboardingView()
}
