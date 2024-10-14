//
//  CreateListView.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI

struct CreateListView: View {

    // MARK: - Properties

    var itemListModel: ItemListModel

    @ObservedObject private var viewModel = ViewModel()

    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack {
            HStack {
                AssetImage.search.image
                    .padding(.leading, 7)
                TextField(AssetString.enterItemName.rawValue, text: $viewModel.inputText)
                AssetImage.cross.image
                    .hidden(viewModel.inputText.isEmpty)
                    .onTapGesture {
                        viewModel.clearInput()
                    }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 36)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black.opacity(0.5))
            )

            VStack {
                ForEach(viewModel.sortedCategories) { category in
                    FoundedItemsScrollView(items: category.items)
                }
            }

            Divider()
                .frame(height: 1)
                .background(.black)
                .hidden(viewModel.sortedCategories.isEmpty)

            VStack(spacing: 5) {
                ForEach(itemListModel.itemsCategory) { category in
                    if category == itemListModel.itemsCategory.first {
                        ProductChapterCell(categoryName: category.name)
                            .cornerRadius(15, corners: [.topLeft, .topRight])
                    } else if category == itemListModel.itemsCategory.last {
                        ProductChapterCell(categoryName: category.name)
                            .cornerRadius(15, corners: [.bottomLeft, .bottomRight])
                    } else {
                        ProductChapterCell(categoryName: category.name)
                    }
                }
            }

            Spacer()
        }
        .onChange(of: viewModel.inputText) { _, newValue in
            let findTargetString = newValue.trimmingCharacters(in: .whitespaces)

            // все найденные айтемы
            let allFoundedItems = itemListModel.items.filter {
                $0.name.lowercased().contains(findTargetString.lowercased())
            }
            // доступные категории
            let categ = Array(Set(allFoundedItems.map { $0.category })).sorted()

            // кновертированная модель
            viewModel.sortedCategories = categ.map { categoryID in
                Category(
                    id: categoryID,
                    name: "",
                    items: allFoundedItems.filter { $0.category == categoryID }
                )
            }
        }
        .screenSettings(isSettingsButtonHidden: false) {
            router.push(.settings)
        }
    }
}
