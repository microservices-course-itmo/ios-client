//
//  RecommendationFilter+ViewModel.swift
//  WineUp
//
//  Created by Александр Пахомов on 06.10.2020.
//

import Foundation

// MARK: - Variables & Init

extension RecommendationFilter {
    final class ViewModel: ObservableObject {

    }
}

// MARK: - Public Methods

extension RecommendationFilter.ViewModel {
    var listViewModel: RecommendationFilter.ItemsList.ViewModel {
        return .init()
    }
}

// MARK: - Helpers

private extension RecommendationFilter.ViewModel {

}
