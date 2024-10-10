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

            GeometryReader { geometry in
                ScrollView(.vertical, showsIndicators: false) {
                    generateContent(in: geometry)
                }
            }
            .frame(height: !viewModel.sortedItems.isEmpty ? 71.5 : 0)
            
            Divider()
                .frame(height: 1)
                .background(.black)
                .hidden(viewModel.sortedItems.isEmpty)

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
            viewModel.sortedItems = itemListModel.items.filter { $0.name.lowercased().contains(findTargetString.lowercased()) }
        }
        .screenSettings(isSettingsButtonHidden: false) {
            router.push(.settings)
        }
    }

    // MARK: - Instance methods

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

                        if item == viewModel.sortedItems.first {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: { d in
                        let result = height
                        if item == viewModel.sortedItems.first {
                            height = 0 // last item
                        }
                        return result
                    })
            }
        }
    }
}

struct RoundedCorner: Shape {
    let radius: CGFloat
    let corners: UIRectCorner

    init(radius: CGFloat = .infinity, corners: UIRectCorner = .allCorners) {
        self.radius = radius
        self.corners = corners
    }

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}


extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
