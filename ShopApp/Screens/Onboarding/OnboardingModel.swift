//
//  OnboardingModel.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

struct OnboardingModel: Identifiable {
    let id = UUID()
    let title: String
    let subTitle: String
    let image: Image
    let tag: Int

    static let model: [Self] = [
        .init(
            title: AssetString.neverForgetWhatYouWantToBuy.rawValue,
            subTitle: AssetString.createLists.rawValue,
            image: AssetImage.onboardingOne.image,
            tag: 0
        ),
        .init(
            title: AssetString.avoidImpulsePurchases.rawValue,
            subTitle: AssetString.planYourListsBefore.rawValue,
            image: AssetImage.onboardingTwo.image,
            tag: 1
        ),
        .init(
            title: AssetString.planCost.rawValue,
            subTitle: AssetString.setPrices.rawValue,
            image: AssetImage.onboardingThree.image,
            tag: 2
        )
    ]
}
