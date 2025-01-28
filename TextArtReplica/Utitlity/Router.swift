//
//  Router.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-28.
//

import SwiftUI


final class Router: ObservableObject {
    @Published var path = NavigationPath()
}

extension EnvironmentValues {
    private struct RouterKey: EnvironmentKey {
        static let defaultValue = Router()
    }

    var router: Router {
        get { self[RouterKey.self] }
        set { self[RouterKey.self] = newValue }
    }
}
