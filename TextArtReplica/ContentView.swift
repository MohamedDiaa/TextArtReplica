//
//  ContentView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-27.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var router = Router()
    var items =  [
        Item(itemType: .folder(title: "FB posts")),
        Item(itemType: .image(name: "default-image-1")),
        Item(itemType: .image(name: "default-image-2")),
        Item(itemType: .folder(title: "Instagram project"))
    ]

    var body: some View {
        
        NavigationStack(path: $router.path) {
            HomeView(items: items)
                .navigationBarTitleDisplayMode(.inline)
        }
        .preferredColorScheme(.light)
        .environment(\.router, router)

    }
}

#Preview {
    ContentView()
}
