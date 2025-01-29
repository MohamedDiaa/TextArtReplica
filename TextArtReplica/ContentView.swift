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
            if modelItems.isEmpty {
                addSamples()
            }
        }

    }

    func addSamples() {
        [
            ModelItem(project: .init(name: "default-image-1"), folder: nil),
            ModelItem(project: .init(name: "default-image-2"), folder: nil),
            ModelItem(project: .init(name: "default-image-3"), folder: nil)
        ].forEach {
            modelContext.insert($0)
        }
    }
}

#Preview {
    ContentView()
}
