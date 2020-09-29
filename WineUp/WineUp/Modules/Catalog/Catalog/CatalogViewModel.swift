//
//  CatalogViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 24.09.2020.
//

import Foundation
import UIKit.UIImage

final class CatalogViewModel: ObservableObject {
    @Published var items: [CatalogItemModel]
    @Published var filtersBarItems: [CatalogFiltersBarItemModel]

    private static let testItems: [CatalogItemModel] = [
        CatalogItemModel(title: "Sarget du Gruaud Larose, AOC Saint-Julien", country: "France", color: .red, wineAstringency: .dry, quantityLiters: 0.75, isLiked: true, chemistry: 25, titleImage: UIImage(imageLiteralResourceName: "testWine 04"), retailerImage: UIImage(imageLiteralResourceName: "image 2"), rating: 3, originalPriceRub: 5_999, discountPercents: 0),
        CatalogItemModel(title: "Luce Brunello Di Montalcino", country: "Italia", color: .red, wineAstringency: .dry, quantityLiters: 0.75, isLiked: false, chemistry: 15, titleImage: UIImage(imageLiteralResourceName: "testWine 02"), retailerImage: UIImage(imageLiteralResourceName: "image 4"), rating: 5, originalPriceRub: 14_878, discountPercents: 13),
        CatalogItemModel(title: "Footsteps Reserve Zinfandel", country: "USA", color: .red, wineAstringency: .semiDry, quantityLiters: 0.75, isLiked: false, chemistry: 30, titleImage: UIImage(imageLiteralResourceName: "testWine 05"), retailerImage: UIImage(imageLiteralResourceName: "image 3"), rating: 4, originalPriceRub: 1_799, discountPercents: 5)
    ]

    init() {
        self.items = CatalogViewModel.testItems
        self.filtersBarItems = [
            CatalogFiltersBarItemModel(title: "Рекомендованные"),
            CatalogFiltersBarItemModel(title: "Цена"),
            CatalogFiltersBarItemModel(title: "Страна"),
            CatalogFiltersBarItemModel(title: "Цвет"),
            CatalogFiltersBarItemModel(title: "Сахар")
        ]
    }

    func filterItemDidTap(_ item: CatalogFiltersBarItemModel) {

    }
}
