//
//  AppEnvironment.swift
//  WineUp
//
//  Created by Александр Пахомов on 28.10.2020.
//

import UIKit
import Combine
import SwiftKeychainWrapper

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(AppState())
        let session = configuredURLSession()
        let webRepositories = configuredWebRepositories(session: session)
        let dbRepositories = configuredPersistentRepositories(appState: appState)
        let services = configuredServices(
            appState: appState,
            dbRepositories: dbRepositories,
            webRepositories: webRepositories
        )
        let diContainer = DIContainer(appState: appState, services: services)
        return AppEnvironment(container: diContainer)
    }

    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 20
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }

    private static func configuredWebRepositories(session: URLSession) -> DIContainer.WebRepositories {
        let userServiceBaseUrl = "http://77.234.215.138:48080/user-service"
        let catalogServiceBaseUrl = "http://77.234.215.138:48080/catalog-service"

        return DIContainer.WebRepositories(
            wine: RealWineWebRepository(session: session, baseURL: catalogServiceBaseUrl),
            auth: RealAuthenticationWebRepository(session: session, baseURL: userServiceBaseUrl),
            brands: RealBrandsWebRepository(session: session, baseURL: catalogServiceBaseUrl),
            grape: RealGrapeWebRepository(session: session, baseURL: catalogServiceBaseUrl),
            producer: RealProducerWebRepository(session: session, baseURL: catalogServiceBaseUrl),
            user: RealUserWebRepository(session: session, baseURL: userServiceBaseUrl),
            winePosition: RealWinePositionWebRepository(session: session, baseURL: catalogServiceBaseUrl),
            truwWinePosition: RealTrueWinePositionWebRepository(session: session, baseURL: catalogServiceBaseUrl),
            shop: RealShopWebRepository(session: session, baseURL: catalogServiceBaseUrl),
            favoritesWebRepository: RealFavoritesWebRepository(session: session, baseURL: catalogServiceBaseUrl)
        )
    }

    private static func configuredPersistentRepositories(appState: Store<AppState>) -> DIContainer.PersistentRepositories {
        let wrapper = KeychainWrapper.standard
        let authCredentialsRepository = RealAuthCredentialsPersistanceRepository(wrapper: wrapper)
        return DIContainer.PersistentRepositories(authCredentials: authCredentialsRepository)
    }

    private static func configuredServices(
        appState: Store<AppState>,
        dbRepositories: DIContainer.PersistentRepositories,
        webRepositories: DIContainer.WebRepositories) -> DIContainer.Services {
        let firebaseService = RealFirebaseService()

        let catalogService = RealCatalogService(
            winePositionWebRepository: webRepositories.truwWinePosition,
            favoritesWebRepository: webRepositories.favoritesWebRepository
        )

        let authenticationService = RealAuthenticationService(
            firebaseService: firebaseService,
            authWebRepository: webRepositories.auth,
            authCredentialsPersistanceRepository: dbRepositories.authCredentials
        )

        return DIContainer.Services(
            firebaseService: firebaseService,
            catalogService: catalogService,
            authenticationService: authenticationService
        )
    }
}

extension DIContainer {
    struct WebRepositories {
        let wine: WineWebRepository
        let auth: AuthenticationWebRepository
        let brands: BrandsWebRepository
        let grape: GrapeWebRepository
        let producer: ProducerWebRepository
        let user: UserWebRepository
        let winePosition: WinePositionWebRepository
        let truwWinePosition: TrueWinePositionWebRepository
        let shop: ShopWebRepository
        let favoritesWebRepository: FavoritesWebRepository
    }

    struct PersistentRepositories {
        let authCredentials: AuthCredentialsPersistanceRepository
    }
}
