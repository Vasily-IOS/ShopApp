//
//  OnboardongPageView.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

struct OnboardingPageView: View {

    // MARK: - Properties

    var onboardingModel: OnboardingModel

    var body: some View {
        VStack {
            Text(onboardingModel.title)
                .font(.system(size: 24, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 16)

            Text(onboardingModel.subTitle)
                .font(.system(size: 16, weight: .light))
                .multilineTextAlignment(.center)
                .padding(.top, 5)
                .padding(.horizontal, 16)

            onboardingModel.image
        }
    }
}

#Preview {
    OnboardingPageView(onboardingModel: OnboardingModel.model.first!)
}
