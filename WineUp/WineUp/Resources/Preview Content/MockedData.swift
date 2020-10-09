//
//  MockedData.swift
//  WineUp
//
//  Created by Александр Пахомов on 04.10.2020.
//

import SwiftUI

// TODO: Wrap all the code here into #if DEBUG #endif block in order to remote mocked data from release
// Currently mocked data is used in 'release' due to lack of server

extension CatalogView.RowItem {
    static let mockedData: [CatalogView.RowItem] = [
        .init(title: "Sarget du Gruaud Larose, AOC Saint-Julien", country: "France", color: .red, wineAstringency: .dry, quantityLiters: 0.75, isLiked: true, chemistry: 25, titleImage: R.image.testWine04()!, retailerImage: UIImage(imageLiteralResourceName: "image 2"), rating: 3, originalPriceRub: 5_999, discountPercents: 0),
        .init(title: "Luce Brunello Di Montalcino", country: "Italia", color: .red, wineAstringency: .dry, quantityLiters: 0.75, isLiked: false, chemistry: 15, titleImage: UIImage(imageLiteralResourceName: "testWine 02"), retailerImage: UIImage(imageLiteralResourceName: "image 4"), rating: 5, originalPriceRub: 14_878, discountPercents: 13),
        .init(title: "Footsteps Reserve Zinfandel", country: "USA", color: .red, wineAstringency: .semiDry, quantityLiters: 0.75, isLiked: false, chemistry: 30, titleImage: UIImage(imageLiteralResourceName: "testWine 05"), retailerImage: UIImage(imageLiteralResourceName: "image 3"), rating: 4, originalPriceRub: 1_799, discountPercents: 5)
    ]
}

extension CatalogFiltersBarView.Item {
    static let mockedData: [CatalogFiltersBarView.Item] = [
        CatalogFiltersBarView.Item(title: "Рекомендованные"),
        CatalogFiltersBarView.Item(title: "Цена"),
        CatalogFiltersBarView.Item(title: "Страна"),
        CatalogFiltersBarView.Item(title: "Цвет"),
        CatalogFiltersBarView.Item(title: "Сахар")
    ]
}

extension PriceFilterView.PredefinedPriceInterval {
    static let mockedData: [PriceFilterView.PredefinedPriceInterval] = [
        .lessThan(maxPriceRub: 1500),
        .between(minPriceRub: 1500, maxPriceRub: 3000),
        .between(minPriceRub: 3000, maxPriceRub: 5000),
        .between(minPriceRub: 5000, maxPriceRub: 10000),
        .greaterThan(minPriceRub: 10000)
    ]
}

struct StubRadioButtonItem: RadioButtonItem {
    var text: String

    var textRepresentation: LocalizedStringKey {
        return LocalizedStringKey(text)
    }

    var id: Int {
        text.hash
    }
}

extension StubRadioButtonItem {
    static let mockedData: [StubRadioButtonItem] = [
        .init(text: "First"),
        .init(text: "Second")
    ]
}
