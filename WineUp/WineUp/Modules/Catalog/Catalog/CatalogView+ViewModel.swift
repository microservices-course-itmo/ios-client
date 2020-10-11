//
//  CatalogView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation
import UIKit.UIImage
import SwiftUI

// MARK: - CatalogView+ViewModel

// TODO: Нужно будет отрефакторить
enum CatalogFiltersBarItemModelType: String, CaseIterable {
    case recommendated = "Рекомендованные"
    case price = "Цена"
    case country = "Страна"
    case color = "Цвет"
    case sugar = "Сахар"

    var view: FilterView {
        switch self {
        case .recommendated:
            return FilterView(RecommendationFilter())
        case .price:
            let items = [PriceFilterItemModel(title: "До 1500"),
                         PriceFilterItemModel(title: "1500-3000"),
                         PriceFilterItemModel(title: "3000-5000"),
                         PriceFilterItemModel(title: "5000-10000"),
                         PriceFilterItemModel(title: "Больше 1000")
            ]
            return FilterView(PriceFilterView(items: items, onItemTap: nil))
        case .color:
            let colortItems = [CharacteristicsFilterItemModel(title: "Белое"),
                               CharacteristicsFilterItemModel(title: "Красное"),
                               CharacteristicsFilterItemModel(title: "Розовое")]
            return FilterView(ColorCharacteristicView(items: colortItems))
        case .sugar:
            let items = [
                CharacteristicsFilterItemModel(title: "Сладкое"),
                CharacteristicsFilterItemModel(title: "Полусладкое"),
                CharacteristicsFilterItemModel(title: "Полусухое"),
                CharacteristicsFilterItemModel(title: "Сухое")
            ]
            return FilterView(SugarCharacteristicView(items: items))
        case .country:
            // TODO: добавить фильтр стран
            return FilterView(RecommendationFilter())
        }
    }
}

extension CatalogView {

    final class ViewModel: ObservableObject {
        let popupPresenter: PopupPresenter
        @Published var items: [CatalogItemModel]
        @Published var filtersBarItems: [CatalogFiltersBarItemModel]
        @Published var searchText: String

        //swiftlint:disable line_length
        private static let testItems: [CatalogItemModel] = [
            CatalogItemModel(title: "Sarget du Gruaud Larose, AOC Saint-Julien", country: "France", color: .red, wineAstringency: .dry, quantityLiters: 0.75, isLiked: true, chemistry: 25, titleImage: UIImage(imageLiteralResourceName: "testWine 04"), retailerImage: UIImage(imageLiteralResourceName: "image 2"), rating: 3, originalPriceRub: 5_999, discountPercents: 0),
            CatalogItemModel(title: "Luce Brunello Di Montalcino", country: "Italia", color: .red, wineAstringency: .dry, quantityLiters: 0.75, isLiked: false, chemistry: 15, titleImage: UIImage(imageLiteralResourceName: "testWine 02"), retailerImage: UIImage(imageLiteralResourceName: "image 4"), rating: 5, originalPriceRub: 14_878, discountPercents: 13),
            CatalogItemModel(title: "Footsteps Reserve Zinfandel", country: "USA", color: .red, wineAstringency: .semiDry, quantityLiters: 0.75, isLiked: false, chemistry: 30, titleImage: UIImage(imageLiteralResourceName: "testWine 05"), retailerImage: UIImage(imageLiteralResourceName: "image 3"), rating: 4, originalPriceRub: 1_799, discountPercents: 5)
        ]

        init(searchText: String, popupPresenter: PopupPresenter) {
            self.popupPresenter = popupPresenter
            self.items = ViewModel.testItems
            self.filtersBarItems = CatalogFiltersBarItemModelType.allCases.map {
                CatalogFiltersBarItemModel(title: $0.rawValue)
            }
            self.searchText = searchText
        }

        func filterItemDidTap(_ item: CatalogFiltersBarItemModel) {
            guard
                let type = CatalogFiltersBarItemModelType.allCases.first(where: { $0.rawValue == item.title })
                else { return }

            self.popupPresenter.popupView = AnyView(
                VStack {
                    Spacer()

                    FilterContainer(filter: type.view, finishAction: {
                        self.popupPresenter.popupView = nil
                    })
                }
            )
        }
    }
}
