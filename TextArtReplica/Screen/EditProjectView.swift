//
//  EditProjectView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-28.
//

import SwiftUI

struct EditProjectView: View {

    @Binding var item: Item

    var body: some View {

        switch item.itemType {
        case let .image(name: name):
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
        default:
            Image(.defaultImage1)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

//#Preview {
//    EditProjectView(item: <#Binding<Item>#>)
//}
