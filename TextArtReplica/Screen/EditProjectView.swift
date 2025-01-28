//
//  EditProjectView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-28.
//

import SwiftUI
import SwiftData

struct EditProjectView: View {

    @Bindable var item: ModelItem

    var body: some View {

        if let name = item.project?.name  {
            Image(name)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

//#Preview {
//    EditProjectView(item: <#Binding<Item>#>)
//}
