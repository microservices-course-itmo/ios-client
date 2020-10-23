//
//  CountryFilterViewModel.swift
//  WineUp
//
//  Created by George on 08.10.2020.
//

import Foundation
import Combine

class CountryFilterViewModel: ObservableObject {

    // MARK: - Public Properties

    @Published var items: [Country] = []

    // MARK: - Lifecycle

    init() {
        self.items = getCountries()
    }
}

// MARK: - Public Properties

extension CountryFilterViewModel {

    func filterItems(searchText: String, items: [Country]) -> [Country] {
        guard !searchText.isEmpty else {
            return items
        }

        let filteredItems = items.filter({ (country) -> Bool in
            return country.name.lowercased().contains(searchText.lowercased())
        })

        return filteredItems
    }

    func setSelectedCountryItem(item: Country, selectedCountries: [Country]?) -> [Country]? {
        var selectedCountriesValue = selectedCountries
        guard let selectedCountriesUnwrapped = selectedCountriesValue else {
            selectedCountriesValue = []
            selectedCountriesValue?.append(item)
            return selectedCountriesValue
        }

        let selectedItem = selectedCountriesUnwrapped.enumerated().first(where: { $0.element.id == item.id })

        if let selectedItem = selectedItem {
            selectedCountriesValue?.remove(at: selectedItem.offset)
        } else {
            selectedCountriesValue?.append(item)
        }

        return selectedCountriesValue
    }

}

// MARK: - Private Properties

private extension CountryFilterViewModel {

    func getCountries() -> [Country] {
        var items = [Country]()
        for code in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            guard let name = NSLocale(localeIdentifier: "en_UK")
                    .displayName(forKey: NSLocale.Key.identifier, value: id) else { continue }
            items.append(Country(id: UUID(), name: name))
        }
        items.sort(by: { $0.name > $1.name })
        return items
    }

}
