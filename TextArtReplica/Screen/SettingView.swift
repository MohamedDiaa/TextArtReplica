//
//  SettingView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-28.
//

import SwiftUI

enum ImportQuality: String, CaseIterable {
    case screenSize = "Screen Size"
    case high =  "High"
    case full = "Full"
}

struct SettingView: View {

    @State var waterMark: Bool = false
    @Environment(\.dismiss) var dismiss
    @State var importQuality: ImportQuality = .screenSize

    var body: some View {

        NavigationStack {
            Form {

                Section {
                    Picker("Import Quality", selection: $importQuality) {
                        ForEach(ImportQuality.allCases,id: \.rawValue) { value in
                            Text(value.rawValue)
                                .tag(value)
                        }
                    }
                    .pickerStyle(.menu)

                    Toggle("WaterMark", isOn: $waterMark)
                }

                Section {
                    HStack {
                        Text("Plan")
                        Spacer(minLength: 0)
                        Text("Free")
                    }

                    NavigationLink(destination: EmptyView()) {
                        Text("Upgrade")

                    }

                    NavigationLink(destination: EmptyView()) {
                        Text("Restore Purchases")
                    }
                }

                Section {
                    NavigationLink(destination: EmptyView()) {
                        Text("Instagram")
                    }
                }

                Section {
                    NavigationLink(destination: EmptyView()) {
                        Text("About Subscriptions")
                    }

                    NavigationLink(destination: EmptyView()) {
                        Text("Terms of Use")
                    }

                    NavigationLink(destination: EmptyView()) {
                        Text("privacy Policy")
                    }
                }

                Section {
                    Text("App Version")

                    NavigationLink(destination: EmptyView()) {
                        Text("Send Feedback")
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                    }

                }
            }
        }
    }
}

#Preview {
    SettingView()
}
