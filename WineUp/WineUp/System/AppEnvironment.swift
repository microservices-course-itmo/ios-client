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
        let credentials = Store<Credentials?>(nil)

        let webRepositories = configuredWebRepositories(session: session, credentials: credentials)
        let dbRepositories = configuredPersistentRepositories(appState: appState)

        let services = configuredServices(
            appState: appState,
            dbRepositories: dbRepositories,
            webRepositories: webRepositories,
            credentials: credentials
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

    private static func configuredWebRepositories(session: URLSession, credentials: Store<Credentials?>) -> DIContainer.WebRepositories {
        let userServiceBaseUrl = "http://77.234.215.138:18080/user-service"
        let catalogServiceBaseUrl = "http://77.234.215.138:18080/catalog-service"

        return DIContainer.WebRepositories(
            wine: RealWineWebRepository(session: session, baseURL: catalogServiceBaseUrl, credentials: credentials),
            auth: RealAuthenticationWebRepository(session: session, baseURL: userServiceBaseUrl, credentials: credentials),
            brands: RealBrandsWebRepository(session: session, baseURL: catalogServiceBaseUrl, credentials: credentials),
            grape: RealGrapeWebRepository(session: session, baseURL: catalogServiceBaseUrl, credentials: credentials),
            producer: RealProducerWebRepository(session: session, baseURL: catalogServiceBaseUrl, credentials: credentials),
            user: RealUserWebRepository(session: session, baseURL: userServiceBaseUrl, credentials: credentials),
            winePosition: RealWinePositionWebRepository(session: session, baseURL: catalogServiceBaseUrl, credentials: credentials),
            truwWinePosition: RealTrueWinePositionWebRepository(session: session, baseURL: catalogServiceBaseUrl, credentials: credentials),
            shop: RealShopWebRepository(session: session, baseURL: catalogServiceBaseUrl, credentials: credentials),
            favoritesWebRepository: RealFavoritesWebRepository(session: session, baseURL: userServiceBaseUrl, credentials: credentials)
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
        webRepositories: DIContainer.WebRepositories,
        credentials: Store<Credentials?>) -> DIContainer.Services {
        let firebaseService = RealFirebaseService()

        let catalogService = RealCatalogService(
            winePositionWebRepository: webRepositories.truwWinePosition,
            favoritesWebRepository: webRepositories.favoritesWebRepository
        )

        let authenticationService = RealAuthenticationService(
            firebaseService: firebaseService,
            authWebRepository: webRepositories.auth,
            userRepository: webRepositories.user,
            authCredentialsPersistanceRepository: dbRepositories.authCredentials,
            credentials: credentials
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
