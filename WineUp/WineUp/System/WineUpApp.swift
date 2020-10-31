//
//  WineUpApp.swift
//  WineUp
//
//  Created by Александр Пахомов on 22.09.2020.
//

import SwiftUI

@main
struct WineUpApp: App {
    private let environment: AppEnvironment
    private let container: DIContainer

    init() {
        environment = AppEnvironment.bootstrap()
        container = environment.container
    }

    var body: some Scene {
        WindowGroup {
            ApplicationRootView(viewModel: .init(container: container))
        }
    }
}
