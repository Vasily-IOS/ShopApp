//
//  MainView.swift
//  ShopApp
//
//  Created by Василий on 13.09.2024.
//

import SwiftUI

struct MainView: View {

    // MARK: - Properties

    @StateObject private var folderService = FolderService()

    @EnvironmentObject var router: AppRouter

    @State private var folderName: String = ""

    var body: some View {
        VStack {
            LabeledContent(AssetString.myLists.rawValue, value: "")
                .font(.system(size: 24, weight: .bold))

            HStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(folderService.baseFolders) { folder in
                            VStack {
                                Text(folder.name)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(folderService.selectedFolderID == folder.id ? .orange : .clear)
                            }
                            .onTapGesture {
                                folderService.selectedFolderID = folder.id
                            }
                        }
                        ForEach(folderService.foldersForSave) { folder in
                            VStack {
                                Text(folder.name)
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(folderService.selectedFolderID == folder.id ? .orange : .clear)
                            }
                            .onTapGesture {
                                folderService.selectedFolderID = folder.id
                            }
                        }
                    }
                }

                AssetImage.addFolder.image
                    .resizable()
                    .frame(width: 25, height: 25)
                    .onTapGesture {
                        router.present(.addFolder { foldeName in
                            router.sheet = nil
                            folderService.addFolder(name: foldeName)
                        })
                    }
            }
            .padding(.top, 15)

            Spacer()

            Button {
                folderService.removeFolder(id: folderService.selectedFolderID)
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
