//
//  CountryItemView.swift
//  WineUp
//
//  Created by George on 03.10.2020.
//

import SwiftUI

struct CountryItemView: View {

    // MARK: - Properties

    var country: Country
    @Binding var selectedCountries: [Country]?

    // MARK: - View

    var body: some View {
        HStack {
            let isSelected = selectedCountries?.contains(where: { $0.id == self.country.id }) ?? false
            let imageName = isSelected ? "circle.fill" : "circle"
            Image(systemName: imageName)

            Text(country.name)
                .font(.title)
                .padding(.leading, 8)
            Spacer()
        }
    }
}
