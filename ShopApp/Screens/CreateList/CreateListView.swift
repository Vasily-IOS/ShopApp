//
//  CreateListView.swift
//  ShopApp
//
//  Created by Василий on 08.10.2024.
//

import SwiftUI

struct CreateListView: View {

    // MARK: - Properties

    @State var inputText = ""

    var items: [Item]

    @State var sortedItems: [Item] = []

    @EnvironmentObject var router: AppRouter

    var body: some View {
        VStack {
            HStack {
                AssetImage.search.image
                    .padding(.leading, 7)
                TextField(AssetString.enterItemName.rawValue, text: $inputText)
                AssetImage.cross.image
                    .hidden(inputText.isEmpty)
                    .onTapGesture {
                        inputText = ""
                    }
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: 36)
            .overlay(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(.black.opacity(0.5))
            )

            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    generateContent(in: geometry)
                }
                .frame(height: UIScreen.main.bounds.height * 0.3)
            }

            Spacer()
        }
        .onChange(of: inputText) { _, value in
            sortedItems = items.filter { $0.name.lowercased().contains(value.lowercased()) }
        }
        .screenSettings(isSettingsButtonHidden: false) {
            router.push(.settings)
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.sortedItems, id: \.self) { sortedItems in
                self.item(for: sortedItems)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if sortedItems == self.sortedItems.first! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if sortedItems == self.sortedItems.first! {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }

    func item(for item: Item) -> some View {
        Text(item.name)
            .padding(.all, 5)
            .font(.body)
            .background(Color.blue)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
}
