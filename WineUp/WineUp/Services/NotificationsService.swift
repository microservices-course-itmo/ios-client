//
//  NotificationsService.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 22.03.2021.
//

import Combine

final class NotificationsService: ObservableObject {

    // MARK: - Init

    private init() {}

    // Public
    public static let shared = NotificationsService()

    @Published var wineId: String?
}
