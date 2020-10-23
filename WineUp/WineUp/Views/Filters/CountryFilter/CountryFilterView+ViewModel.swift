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

        @Published var countries: [Country] = []
        @Published var selectedCountries: [Country] = []
        @Published var searchText: String = "" {
            didSet {
                searchTextDidSet()
            }
        }

        private static let allCountries = ViewModel.getCountries()

        init() {
            updateAvailableCountries()
        }

        // MARK: Helpers

        func searchTextDidSet() {
            updateAvailableCountries()
        }

        private func updateAvailableCountries() {
            countries = ViewModel.filter(ViewModel.allCountries, with: searchText)
        }

        private static func filter(_ countries: [Country], with pattern: String) -> [Country] {
            guard !pattern.isEmpty else {
                return countries
            }

            return countries.filter {
                $0.name.lowercased().contains(pattern.lowercased())
            }
        }

        private static func getCountries() -> [Country] {
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
}

// MARK: - CountryFilterView+Country

extension CountryFilterView {
    struct Country: Equatable {
        var id: String
        var name: String
    }
}
