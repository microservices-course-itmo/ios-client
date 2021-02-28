//
//  CountryFilterView+ViewModel.swift
//  WineUp
//
//  Created by George on 08.10.2020.
//

import Foundation
import Combine

// MARK: - CountryFilterView+ViewModel

extension CountryFilterView {
    final class ViewModel: ObservableObject {

        private lazy var cachedAllCountries = ViewModel.getAllCountries()

        func getCountries(with pattern: String) -> [Country] {
            ViewModel.filter(cachedAllCountries, with: pattern)
        }

        // MARK: Helpers

        private static func filter(_ countries: [Country], with pattern: String) -> [Country] {
            guard !pattern.isEmpty else {
                return countries
            }

            return countries.filter {
                $0.name.lowercased().contains(pattern.lowercased())
            }
        }

        static func getAllCountries() -> [Country] {
            Country.allCases
        }
    }
}

struct Country: Equatable {
    var id: String
    var name: String

    static var allCases: [Country] {
        var items = [Country]()
        for code in NSLocale.isoCountryCodes {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            guard let name = NSLocale(localeIdentifier: "en_UK")
                    .displayName(forKey: NSLocale.Key.identifier, value: id) else { continue }
            items.append(Country(id: id, name: name))
        }
        items.sort(by: { $0.name > $1.name })
        return items
    }
}
