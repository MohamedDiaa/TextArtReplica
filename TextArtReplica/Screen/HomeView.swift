//
//  HomeView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-27.
//

import SwiftUI

enum TxItemType: Hashable {
    case image(name: String)
    case folder(title: String)
}

struct Item: Hashable {
    var itemType: TxItemType
}


struct HomeView: View {

    @State var showInstagramFollowBar: Bool = true
    @State var showConfirmation: Bool = false
    @State var showCreateFolderAlert: Bool = false
    @State var newFolderName: String = ""
    @State var toggleSelectItems: Bool = false
    @State var showSettingView: Bool = false


    @State var items: [Item] =  [
        Item(itemType: .folder(title: "FB posts")),
        Item(itemType: .image(name: "default-image-1")),
        Item(itemType: .image(name: "default-image-2")),
        Item(itemType: .folder(title: "Instagram project"))
    ]

    @State var selectedItems: IndexSet = .init()

    var body: some View {

        ScrollView(.vertical) {
            VStack {
                if showInstagramFollowBar {
                    followInstagramBar()
                }

                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {

                    ForEach(items ,id:\.self) { item in
                        itemView(item: item)
                            .overlay(content: {
                                if let index = items.firstIndex(of: item),
                                   selectedItems.contains(index) {
                                    Rectangle()
                                        .fill(.gray.opacity(0.8))
                                        .overlay {
                                            Image(systemName: "checkmark")
                                                .foregroundStyle(.white)
                                        }
                                }
                            })
                            .onTapGesture {
                                switch toggleSelectItems {
                                case true:
                                    guard let index = items.firstIndex(of: item)
                                    else { return }
                                    if selectedItems.contains(index) {
                                        selectedItems.remove(index)
                                    } else {
                                        selectedItems.insert(index)
                                    }

                                case false:
                                    break
                                }
                            }
                    }
                }
                .frame(maxHeight: .infinity)
                .padding(.horizontal,5)
            }
        }
        // .background(.gray.opacity(0.3))
        .navigationTitle(toggleSelectItems ? "Selected Items (\(selectedItems.count))" : "Projects")
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
                    Button {

                    } label: {
                        HStack {
                            Image(systemName: "plus")
                            Text("Create New Project")
                        }
                        .foregroundStyle(.black)
                    }

                }
            }
            else {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        selectedItems = .init()
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
                    .disabled(selectedItems.isEmpty)
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

    @ViewBuilder
    func itemView(item: Item) -> some View {

        switch item.itemType {
        case let .folder(title):

            RoundedRectangle(cornerRadius: 5)
                .fill(.gray.opacity(0.4))
                .frame(minHeight: 150)
                .overlay {
                    Text(title)
                        .font(.callout.bold())
                }

        case let .image(name: name):
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
    }
}

#Preview {
    HomeView()
}
