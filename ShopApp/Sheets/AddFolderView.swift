//
//  AddFolderView.swift
//  ShopApp
//
//  Created by Василий on 17.09.2024.
//

import SwiftUI

struct AddFolderView: View {

    // MARK: - Properties

    var onFolderNameEntered: ((String) -> ())

    @State private var folderName = ""

    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack {
            Text(AssetString.newFolder.rawValue)
                .font(.system(size: 20))
            TextField(AssetString.nameOfFolder.rawValue, text: $folderName)
                .font(.system(size: 16))
                .padding(.top, 16)
            Rectangle()
                .frame(height: 1)
            HStack {
                Spacer()
                Button {
                    router.dismissSheet()
                } label: {
                    HStack {
                        Text(AssetString.cancel.rawValue)
                            .foregroundStyle(.black)
                            .font(.system(size: 20, weight: .bold))
                            .padding(.horizontal)
                    }
                    .frame(height: 44)
                    .background(.white)
                }
                Spacer()
                Button {
                    onFolderNameEntered(folderName)
                } label: {
                    HStack {
                        Text(AssetString.save.rawValue)
                            .foregroundStyle(.white)
                            .font(.system(size: 20))
                            .padding(.horizontal)
                    }
                    .frame(height: 44)
                    .background(.orange)
                    .cornerRadius(30)
                }
                Spacer()
            }
            .padding(.top, 25)
            Spacer()
        }
        .padding(.top, 16)
        .padding(.horizontal, 16)
    }
}
