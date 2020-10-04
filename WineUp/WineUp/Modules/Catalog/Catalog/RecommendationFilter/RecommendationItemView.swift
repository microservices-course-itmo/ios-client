//
//  RecommendationItemView.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 04.10.2020.
//

import SwiftUI

private extension CGFloat {
    static let checkmarkSize: CGFloat = 18.0
}

struct RecommendationItemView: View {

    // Properties
    let item: RecommendationFilterList.Item
    @Binding var pickedItem: RecommendationFilterList.Item?

    // MARK: - View

    var body: some View {
        HStack {
            checkmarkImage
                .resizable()
                .frame(width: .checkmarkSize, height: .checkmarkSize)
                .foregroundColor(checkmarkColor)
            Text(item.text)
                .font(.title3)
            Spacer()
        }
    }

    // MARK: - Private

    private var checkmarkImage: Image {
        Image(systemName: isPicked ? "checkmark.square" : "square")
    }

    private var checkmarkColor: Color {
        isPicked ? .init(hex: 0x006400) : .black
    }

    private var isPicked: Bool {
        guard let pickedItem = pickedItem else { return false }
        return pickedItem.id == item.id
    }
}

#if DEBUG
struct RecommendationItemView_Previews: PreviewProvider {

    @ObservedObject static var viewModel: RecommendationFilterList.ViewModel = {
        let viewModel =
            RecommendationFilterList.ViewModel(variants: ["Наиболее вам подходящие",
                                                          "По рейтингу"])
        viewModel.pickedItem = viewModel.variants[0]
        return viewModel
    }()

    static var previews: some View {
        Group {
            RecommendationItemView(item: viewModel.variants[0], pickedItem: $viewModel.pickedItem)
                .previewLayout(.fixed(width: 300, height: 50))

            RecommendationItemView(item: viewModel.variants[1], pickedItem: $viewModel.pickedItem)
                .previewLayout(.fixed(width: 300, height: 50))
        }

    }
}
#endif
