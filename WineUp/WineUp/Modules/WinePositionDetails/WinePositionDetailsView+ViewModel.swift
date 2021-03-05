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
        private var togglingLikeSuccess: Loadable<Void> = .notRequested

        init(container: DIContainer, winePosition: WinePosition) {
            self.container = container
            self.winePosition = winePosition
            // TODO: Real data needed
            self.details = .init(
                winePositionId: winePosition.id,
                suggestions: [winePosition, winePosition, winePosition]
            )
        }

        /// Designed only for current position in details
        func toggleLike() {
            let bag = CancelBag()
            togglingLikeSuccess.setIsLoading(cancelBag: bag)
            winePosition.isLiked.toggle()

            container.services.catalogService
                .likeWinePosition(winePositionId: winePosition.id, like: winePosition.isLiked)
                .sinkToLoadable { self.togglingLikeSuccess = $0 }
                .store(in: bag)
        }

        /// Designed only for wine position from suggestions
        func toggleLike(of winePosition: WinePosition) {
            guard let index = details.suggestions.firstIndex(of: winePosition) else {
                assertionFailure()
                return
            }

            let bag = CancelBag()
            togglingLikeSuccess.setIsLoading(cancelBag: bag)
            details.suggestions[index].isLiked.toggle()

            container.services.catalogService
                .likeWinePosition(winePositionId: winePosition.id, like: !winePosition.isLiked)
                .sinkToLoadable { self.togglingLikeSuccess = $0 }
                .store(in: bag)
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
