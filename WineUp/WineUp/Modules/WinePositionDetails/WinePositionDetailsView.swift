//
//  WinePositionDetailsView.swift
//  WineUp
//
//  Created by Александр Пахомов on 29.10.2020.
//

import SwiftUI

// MARK: - View

struct WinePositionDetailsView: View {

    @ObservedObject private(set) var viewModel: ViewModel

    var body: some View {
        ScrollView {
            VStack {
                WinePositionView(item: viewModel.winePosition)
            }
        }
    }
}
