//
//  MockedData.swift
//  WineUp
//
//  Created by Александр Пахомов on 04.10.2020.
//

import UIKit.UIImage

// TODO: Wrap all the code here into #if DEBUG #endif block in order to remote mocked data from release
// Currently mocked data is used in 'release' due to lack of server

//swiftlint:disable all

extension CatalogItemModel {
    static let mockedData: [CatalogItemModel] = [
        CatalogItemModel(title: "Sarget du Gruaud Larose, AOC Saint-Julien", country: "France", color: .red, wineAstringency: .dry, quantityLiters: 0.75, isLiked: true, chemistry: 25, titleImage: R.image.testWine04()!, retailerImage: UIImage(imageLiteralResourceName: "image 2"), rating: 3, originalPriceRub: 5_999, discountPercents: 0),
        CatalogItemModel(title: "Luce Brunello Di Montalcino", country: "Italia", color: .red, wineAstringency: .dry, quantityLiters: 0.75, isLiked: false, chemistry: 15, titleImage: UIImage(imageLiteralResourceName: "testWine 02"), retailerImage: UIImage(imageLiteralResourceName: "image 4"), rating: 5, originalPriceRub: 14_878, discountPercents: 13),
        CatalogItemModel(title: "Footsteps Reserve Zinfandel", country: "USA", color: .red, wineAstringency: .semiDry, quantityLiters: 0.75, isLiked: false, chemistry: 30, titleImage: UIImage(imageLiteralResourceName: "testWine 05"), retailerImage: UIImage(imageLiteralResourceName: "image 3"), rating: 4, originalPriceRub: 1_799, discountPercents: 5)
    ]
}

extension CatalogFiltersBarItemModel {
    static let mockedData: [CatalogFiltersBarItemModel] = [
        CatalogFiltersBarItemModel(title: "Рекомендованные"),
        CatalogFiltersBarItemModel(title: "Цена"),
        CatalogFiltersBarItemModel(title: "Страна"),
        CatalogFiltersBarItemModel(title: "Цвет"),
        CatalogFiltersBarItemModel(title: "Сахар")
    ]
}
