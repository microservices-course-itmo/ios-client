//
//  MockedData.swift
//  WineUp
//
//  Created by Александр Пахомов on 04.10.2020.
//

import SwiftUI

#if DEBUG

extension WinePosition {
    static let mockedData: [WinePosition] = [
        .init(title: "Sarget du Gruaud Larose, AOC Saint-Julien", country: "France", color: .red, year: "2014", wineSugar: .dry, quantityLiters: 0.75, isLiked: true, chemistry: 25, titleImage: UIImage(imageLiteralResourceName: "testWine 04"), retailerName: "Росал", rating: 3, originalPriceRub: 5_999, discountPercents: 0),
        .init(title: "Luce Brunello Di Montalcino", country: "Italia", color: .red, year: "2019", wineSugar: .dry, quantityLiters: 0.75, isLiked: false, chemistry: 15, titleImage: UIImage(imageLiteralResourceName: "testWine 02"), retailerName: "SimpleWine", rating: 5, originalPriceRub: 14_878, discountPercents: 13),
        .init(title: "Footsteps Reserve Zinfandel", country: "USA", color: .red, year: "2018", wineSugar: .semiDry, quantityLiters: 0.75, isLiked: false, chemistry: 30, titleImage: UIImage(imageLiteralResourceName: "testWine 05"),retailerName: "Лента", rating: 4, originalPriceRub: 1_799, discountPercents: 5)
    ]
}

extension WinePosition {
    var details: Details {
        .init(
            winePositionId: id,
            tasteDescription: "Вкус вина — очень сухой, свежий и бархатистый, с приятной горчинкой, нотами белых цветов в нежном букете",
            dishSuggestions: "Прекрасно в сочетании с жареным ягненком, свининой с овощами и сырами средней выдержки",
            reviews: [
                WinePosition.Details.Review(reviewerFullName: "Марков Павел", rating: 5, review: "Очень достойное. В меру фруктовое, прекрасно пьется. В моем личном рейтинге из всех российских вин уверенно занимает первое место", timestamp: Date()),
                .init(reviewerFullName: "Петр Петров", rating: 3, review: "Вино очень понравилось . Легкое , приятно пьётся. Легкий аромат скошенных трав и фруктов", timestamp: Date())
            ],
            suggestions: WinePosition.mockedData
        )
    }
}

extension CatalogFiltersBarView.Item {
    static let mockedData: [CatalogFiltersBarView.Item] = [
        .recomendation,
        .price,
        .country,
        .wineColor,
        .wineSugar
    ]
}

extension PriceFilter.PredefinedPriceInterval {
    static let mockedData: [PriceFilter.PredefinedPriceInterval] = [
        .lessThan(maxPriceRub: 1500),
        .between(minPriceRub: 1500, maxPriceRub: 3000),
        .between(minPriceRub: 3000, maxPriceRub: 5000),
        .between(minPriceRub: 5000, maxPriceRub: 10000),
        .greaterThan(minPriceRub: 10000)
    ]
}

extension StubRadioButtonItem {
    static let mockedData: [StubRadioButtonItem] = [
        .init(text: "First"),
        .init(text: "Second")
    ]
}

extension UserJson {
    static let mockedData: [UserJson] = [
        UserJson(id: "1", role: "USER"),
        UserJson(id: "2", role: "USER")
    ]
}

#endif
