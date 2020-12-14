//
//  WinePositionDetailsView+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 29.10.2020.
//

import Foundation

// MARK: - WinePositionDetailsView+ViewModel

extension WinePositionDetailsView {
    final class ViewModel: ObservableObject {

        @Published var winePosition: WinePosition
        @Published var details: WinePosition.Details

        private let container: DIContainer
        private let cancelBag = CancelBag()

        init(container: DIContainer, winePosition: WinePosition) {
            self.container = container
            self.winePosition = winePosition
            self.details = winePosition.details
        }
    }
}

// MARK: - WinePosition+Details+Review

extension WinePosition.Details {
    struct Review: Equatable, Identifiable {
        /// Unique random id of instance
        var id = UUID()
        /// Full name (surname and first name) of the reviewer
        var reviewerFullName: String
        /// Rating in [0; 5] interval
        var rating: Float
        /// Text of the review
        var review: String
        /// Timestamp of review creation
        var timestamp: Date
    }
}

// MARK: - Preview

#if DEBUG
extension WinePositionDetailsView.ViewModel {
    static let preview = WinePositionDetailsView.ViewModel(container: .preview, winePosition: WinePosition.mockedData[0])
}
#endif
