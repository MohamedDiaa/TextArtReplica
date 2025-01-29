//
//  CreateProjectView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-28.
//

import SwiftUI
import PhotosUI

enum ProjectOptions: String, CaseIterable, Hashable {
    case photoLibray = "Photo Library"
    case colors = "Colors"
    case stockPhotos = "Stock Photos"
}
struct CreateProjectView: View {

    @State var options: ProjectOptions = .photoLibray

    @State private var pickerItem: PhotosPickerItem?
    @State private var selectedImage: Image?

    var body: some View {

        VStack {
            Picker("Select", selection: $options) {
                ForEach(ProjectOptions.allCases, id: \.self) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }.pickerStyle(.segmented)



            PhotosPicker("Select a picture", selection: $pickerItem, matching: .images)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(.black))

            if let selectedImage {
                selectedImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

            Spacer(minLength: 0)

        }
        .padding(.vertical)
        .onChange(of: pickerItem) {
            Task {
                selectedImage = try await pickerItem?.loadTransferable(type: Image.self)
            }
        }
    }
}

#Preview {
    CreateProjectView()
}
