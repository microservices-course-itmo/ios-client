//
//  RecommendationItemView.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let checkmarkSize: CGFloat = 18.0
}

private extension Color {
    static let pickedCheckmark = Color(hex: 0x006400)
    static let normalCheckmark = Color.black
}

private extension Image {
    static let pickedCheckmark = Image(systemName: "checkmark.square")
    static let normalCheckmark = Image(systemName: "square")
}

private extension LocalizedStringKey {
    static let recomendedOrder = LocalizedStringKey("Наиболее вам подходящие")
    static let basedOnRatingOrder = LocalizedStringKey("По рейтингу")
}

private extension Font {
    static let sortOrder: Font = .title3
}

// MARK: - View

extension RecommendationFilter.ItemsList {
    struct ItemView: View {

        let item: Item
        @Binding var pickedItem: Item?

        var body: some View {
            HStack {
                checkmarkImage
                    .resizable()
                    .frame(width: .checkmarkSize, height: .checkmarkSize)
                    .foregroundColor(checkmarkColor)
                Text(textFor(item.sortOrder))
                    .font(.sortOrder)
                Spacer()
            }
        }
    }
}

// MARK: - Helpers

private extension RecommendationFilter.ItemsList.ItemView {
    func textFor(_ sortOrder: CatalogSortOrder) -> LocalizedStringKey {
        switch sortOrder {
        case .recommended:
            return .recomendedOrder
        case .baseedOnRating:
            return .basedOnRatingOrder
        }
    }

    var checkmarkImage: Image {
        isPicked ? .pickedCheckmark : .normalCheckmark
    }

    var checkmarkColor: Color {
        isPicked ? .pickedCheckmark : .normalCheckmark
    }

    var isPicked: Bool {
        guard let pickedItem = pickedItem else { return false }
        return pickedItem.id == item.id
    }
}

// MARK: - Preview

#if DEBUG
struct RecommendationItemView_Previews: PreviewProvider {

    typealias ItemsList = RecommendationFilter.ItemsList

    @ObservedObject static var viewModel: ItemsList.ViewModel = {
        let viewModel = ItemsList.ViewModel(orders: [.recommended, .baseedOnRating])
        viewModel.pickedItem = viewModel.items[0]
        return viewModel
    }()

    static var previews: some View {
        Group {
            ItemsList.ItemView(item: viewModel.items[0], pickedItem: $viewModel.pickedItem)
                .previewLayout(.fixed(width: 300, height: 50))

            ItemsList.ItemView(item: viewModel.items[1], pickedItem: $viewModel.pickedItem)
                .previewLayout(.fixed(width: 300, height: 50))
        }

    }
}
#endif
