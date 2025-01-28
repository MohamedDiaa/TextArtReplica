//
//  ContentView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-27.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Query var modelItems: [ModelItem]
    @Environment(\.modelContext) var modelContext

    @StateObject private var router = Router()

    var body: some View {

        NavigationStack(path: $router.path) {
            HomeView()
                .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.light)
        .environment(\.router, router)
        .onAppear {
           // addSamples()
        }

    }

    func addSamples() {
        let f = ModelItem(project: .init(name: "default-image-1"), folder: nil)
        let f2 = ModelItem(project: .init(name: "default-image-2"), folder: nil)
        modelContext.insert(f)
        modelContext.insert(f2)
    }
}

#Preview {
    ContentView()
}
