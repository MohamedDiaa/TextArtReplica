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

    @State var images: [String] =  [
        "arrow.trianglehead.clockwise.hi",
        "inset.filled.bottomtrailing.rectangle",
        "person.fill.and.arrow.left.and.arrow.right.outward",
        "person.badge.plus",
        "sharedwithyou.circle",
        "person.2.slash",
        "forward.end.circle.fill",
        "shareplay",
        "inset.filled.bottomleft.rectangle",
        "arrow.trianglehead.clockwise",
        "person.badge.shield.exclamationmark",
        "person.2.circle.fill",
        "person.badge.clock",
        "inset.filled.rectangle.and.person.filled.circle.fill"
    ]


    var body: some View {

        VStack {
            if showInstagramFollowBar {
                followInstagramBar()
            }

            LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {

                ForEach(images,id:\.self) { img in

                    Image(systemName: img)
                        .padding(20)
                }
            }

            Spacer(minLength: 0)
        }
//        .background(.gray.opacity(0.3))
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
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Image(systemName: "plus")
                        Text("Create New Project")
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

                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {

                        } label: {
                            Text("Delete")
                        }

                        Spacer(minLength: 0)

                        Button {

                        } label: {
                            Text("Move")
                        }
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
