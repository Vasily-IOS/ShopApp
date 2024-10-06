//
//  MainView.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

struct MainView: View {

    // MARK: - Properties

    @StateObject private var viewModel = ViewModel()

    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack {
            LabeledContent(AssetString.myLists.rawValue, value: "")
                .font(.system(size: 24, weight: .bold))

            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.baseFolders) { folder in
                            VStack {
                                Text(folder.name)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(viewModel.isSelected(folder.id) ? .orange : .clear)
                            }
                            .onTapGesture {
                                viewModel.selectedFolderID = folder.id
                            }
                        }
                        ForEach(viewModel.foldersForSave) { folder in
                            VStack {
                                Text(folder.name)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(viewModel.isSelected(folder.id) ? .orange : .clear)
                            }
                            .onTapGesture {
                                viewModel.selectedFolderID = folder.id
                            }
                        }
                    }
                }

                AssetImage.addFolder.image
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        router.present(.addItem(AssetString.newList.rawValue, AssetString.nameOfList.rawValue) { name in
                            viewModel.addFolder(name: name)
                        })
                    }
            }
            .padding(.top, 15)

            Spacer()

            Button {
//                folderService.removeFolder(id: folderService.selectedFolderID)
//                router.present(.addItem(AssetString.newFolder.rawValue, AssetString.nameOfFolder.rawValue) { result in
//                    print(result)
//                })
            } label: {
                HStack {
                    Spacer()
                    Text(AssetString.createList.rawValue)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .frame(height: 54)
            .background(.orange)
            .cornerRadius(16)
        }
        .padding(.vertical, 25)
        .padding(.horizontal, 16)
    }
}

#Preview {
    MainView()
}
