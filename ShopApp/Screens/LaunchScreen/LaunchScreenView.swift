//
//  LaunchScreenView.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

struct LaunchScreenView: View {

    // MARK: - Properties

    @State var isSpinning = false

    var body: some View {
        ZStack {
            Color.orange
                .ignoresSafeArea()
            AssetImage.launchScreen.image
                .rotationEffect(.degrees(isSpinning ? 360 : 0))
                .animation(.easeInOut(duration: 1.5), value: isSpinning)
        }
        .onAppear {
            isSpinning.toggle()
        }
    }
}

#Preview {
    LaunchScreenView()
}
