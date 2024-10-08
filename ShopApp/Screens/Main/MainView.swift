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

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

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
                                    .padding(.horizontal, 3)
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
                                    .padding(.horizontal, 3)
                                    .contextMenu {
                                        Button {
                                            viewModel.removeFolder(id: folder.id)
                                        } label: {
                                            Text(AssetString.removeFolderWithLists.rawValue)
                                        }
                                    }
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
                        router.present(.addItem(AssetString.newFolder.rawValue, AssetString.nameOfFolder.rawValue) { name in
                            viewModel.addFolder(name: name) {
                                router.dismissSheet()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    viewModel.isAlertPresented.toggle()
                                }
                            }
                        })
                    }
                    .alert(isPresented: $viewModel.isAlertPresented) {
                        Alert(title: Text(AssetString.folderNameAlreadyContains.rawValue))
                    }
            }
            .padding(.top, 15)

//            ScrollView(showsIndicators: false) {
//                LazyVGrid(columns: columns, spacing: 16) {
//                    ForEach(0..<20) { item in
//                        ListCellView(item: item)
//                    }
//                }
//                .padding(.top, 10)
//            }

            Spacer()

            Button {
                router.push(.createList(viewModel.getItems()))
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
