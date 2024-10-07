//
//  AddListOrFolderView.swift
//  ShopApp
//
//  Created by Василий on 06.10.2024.
//

import SwiftUI

struct AddListOrFolderView: View {

    // MARK: - Properties

    var title: String

    var placeholder: String

    var completion: ((String) -> ())

    @State var itemName: String = ""

    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 20))
            TextField(placeholder, text: $itemName)
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
                    router.dismissSheet()
                    completion(itemName)
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
