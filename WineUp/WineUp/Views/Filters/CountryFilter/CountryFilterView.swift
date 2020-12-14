//
//  CountryFilterView.swift
//  WineUp
//
//  Created by George on 03.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension CGFloat {
    static let countriesSpacing: CGFloat = 0
    static let maxCountriesListHeight = UIScreen.main.bounds.height * 0.5
}

// MARK: - View

struct CountryFilterView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        VStack {
            SearchBarView(text: $viewModel.searchText)

            RadioButton(
                spacing: .countriesSpacing,
                items: viewModel.countries,
                isScrollable: true,
                checkedItems: $viewModel.selectedCountries
            )
            .frame(maxHeight: .maxCountriesListHeight)
        }

    }
}

// MARK: - RadioButtonItem

extension CountryFilterView.Country: RadioButtonItem {
    var textRepresentation: LocalizedStringKey {
        LocalizedStringKey(name)
    }
}

// MARK: - Preview

#if DEBUG
struct CountryFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CountryFilterView(viewModel: .init())
    }
}
#endif
