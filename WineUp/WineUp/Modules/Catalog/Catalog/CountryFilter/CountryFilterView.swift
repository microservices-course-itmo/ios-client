//
//  CountryFilterView.swift
//  WineUp
//
//  Created by George on 03.10.2020.
//

import SwiftUI

struct CountryFilterView: View {

    // MARK: - Private Properties

    @ObservedObject private var viewModel = CountryFilterViewModel()
    @State private var selectedCountries: [Country]?
    @State var searchText: String

    // MARK: - View

    var body: some View {
        VStack {
            SearchBarView(text: $searchText)
            List(self.viewModel.filterItems(searchText: searchText, items: viewModel.items)) { item in
                CountryItemView(country: item, selectedCountries: $selectedCountries)
                    .onTapGesture(count: 1, perform: {
                        self.selectedCountries = viewModel.setSelectedCountryItem(
                            item: item,
                            selectedCountries: self.selectedCountries
                        )
                    })
            }
        }

    }
}

// MARK: - Preview Settings

struct CountryFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CountryFilterView(searchText: "")
    }
}
