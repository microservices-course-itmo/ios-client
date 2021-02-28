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

    @Binding var selected: [Country]

    @StateObject private var viewModel = ViewModel()
    @State private var searchText = ""

    var body: some View {
        VStack {
            SearchBarView(text: $searchText)

            RadioButton(
                spacing: .countriesSpacing,
                items: allCases,
                isScrollable: true,
                checkedItems: $selected
            )
            .frame(maxHeight: .maxCountriesListHeight)
        }
    }

    private var allCases: [Country] {
        viewModel.getCountries(with: searchText)
    }
}

// MARK: - RadioButtonItem

extension Country: RadioButtonItem {
    var textRepresentation: LocalizedStringKey {
        LocalizedStringKey(name)
    }
}

// MARK: - Preview

#if DEBUG
struct CountryFilterView_Previews: PreviewProvider {
    static var previews: some View {
        CountryFilterView(selected: .constant([]))
    }
}
#endif
