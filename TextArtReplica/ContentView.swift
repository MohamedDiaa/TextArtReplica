//
//  ContentView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-27.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var router = Router()

    var body: some View {
        
        NavigationStack(path: $router.path) {
            HomeView()
                .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.light)
        .environment(\.router, router)

    }
}

#Preview {
    ContentView()
}
