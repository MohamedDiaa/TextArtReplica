//
//  TextArtReplicaApp.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-27.
//

import SwiftUI
import SwiftData

@main
struct TextArtReplicaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: ModelItem.self)
    }
}
