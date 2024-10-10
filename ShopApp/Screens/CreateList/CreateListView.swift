//
//  CreateListView.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI

struct CreateListView: View {

    // MARK: - Properties

    var items: [Item]

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

            GeometryReader { geometry in
                Text("\(geometry.size.height)")
                    .padding(.bottom, 30)

                ScrollView(.vertical, showsIndicators: false) {
                    generateContent(in: geometry)
                }
            }
            .frame(height: !viewModel.sortedItems.isEmpty ? UIScreen.main.bounds.height * 0.2 : 0)
            .animation(.smooth, value: !viewModel.sortedItems.isEmpty)
            Text("Test text")

            Spacer()
        }
        .onChange(of: viewModel.inputText) { _, newValue in
            let findTargetString = newValue.trimmingCharacters(in: .whitespaces)
            viewModel.sortedItems = items.filter { $0.name.lowercased().contains(findTargetString.lowercased()) }
        }
        .screenSettings(isSettingsButtonHidden: false) {
            router.push(.settings)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(viewModel.sortedItems, id: \.self) { item in
                CustomCellView(item: item)
                    .padding(.all, 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == viewModel.sortedItems.first! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if item == viewModel.sortedItems.first! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
}
