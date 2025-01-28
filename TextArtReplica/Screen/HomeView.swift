//
//  HomeView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-27.
//

import SwiftUI

struct HomeView: View {

    @State var showInstagramFollowBar: Bool = true
    @State var showConfirmation: Bool = false
    @State var showCreateFolderAlert: Bool = false
    @State var newFolderName: String = ""
    @State var toggleSelectItems: Bool = false
    @State var showSettingView: Bool = false

    var body: some View {

        VStack {
            if showInstagramFollowBar {
                followInstagramBar()
            }

            Text("Hello")

            Spacer(minLength: 0)
        }
        .navigationTitle(toggleSelectItems ? "Selected Items (0)" : "Projects")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            if(!toggleSelectItems) {
                ToolbarItemGroup(placement: .topBarLeading) {

                    Button {
                        showSettingView = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }

                    Button {

                    } label: {
                        Image(systemName: "crown.fill")
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {

                    Button {
                        toggleSelectItems.toggle()

                    } label: {
                        Image(systemName: "checkmark.square")

                    }

                    Button {

                    } label: {
                        Image(systemName: "plus")
                            .onTapGesture {

                                showConfirmation = true
                            }
                    }
                }
            }
            else {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        toggleSelectItems.toggle()
                    } label: {
                        Text("Done")
                    }

                }
            }
        }
        .confirmationDialog("Select", isPresented: $showConfirmation) {
            Button("Create Project"){}
            Button("Create Folder"){ showCreateFolderAlert = true }
        }
        .alert("Create Folder", isPresented: $showCreateFolderAlert) {
            TextField("Folder name", text: $newFolderName)
            Button("Create") {}
            Button("Cancel", role: .cancel) { }
        }
        .sheet(isPresented: $showSettingView) {
            SettingView()
        }

    }


    @ViewBuilder
    func followInstagramBar() -> some View {

        Rectangle()
            .fill(Color.orange)
            .frame(maxWidth: .infinity)
            .frame(height: 40)
            .overlay(alignment: .center) {
                Text("Follow on twitter")
                    .foregroundStyle(.white)

            }
            .overlay(alignment: .leading) {
                Button {
                    withAnimation {
                        showInstagramFollowBar = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .foregroundStyle(.white)
                        .padding()
                        .offset(x: 10)
                }
            }
    }
}

#Preview {
    HomeView()
}
