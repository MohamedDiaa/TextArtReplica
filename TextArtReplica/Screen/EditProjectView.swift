//
//  EditProjectView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-28.
//

import SwiftUI
import SwiftData


var fonts =  ["Filled\nTo\nThe\nBRIM",
              "Modern\nTimes",
              "mark",
              "The\nMODERN\nDAYS",
              "Just My\nType"]

struct EditProjectView: View {

    @Bindable var item: ModelItem
    @State private var editOptionSelected: EditOption = .style
    @State private var selectedColorType: ColorOption = .color

    @State var sliderOption: CGFloat = 0.3

    var body: some View {

        VStack {
            VStack {
                if let name = item.project?.name  {
                    ZStack {
                        Image(name)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                }

                Spacer(minLength: 0)
            }
            .background(.gray.opacity(0.15))

            editOptionView(editOptionSelected)

            HStack {

                ForEach(EditOption.allCases, id: \.self) { option in

                    VStack {
                        Button {
                            withAnimation(.smooth) {
                                editOptionSelected = option
                            }
                        } label: {
                            VStack {
                                Image(systemName: option.icon)
                                    .font(.system(size: 30))

                                Text(option.title.uppercased())
                                    .font(.caption2)
                            }
                        }
                        .foregroundStyle(editOptionSelected == option ? Color.orange : .gray.opacity(0.6))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .safeAreaPadding()
    }

    @ViewBuilder
    func editOptionView(_ option: EditOption) -> some View {

        switch option {
        case .style:
            styleView()
        case .color:
            colorView()
        case .adjust:
            adjustView()
        case .canvas:
            canvasView()
        }
    }

    @ViewBuilder
    func styleView() -> some View  {

        ScrollView(.horizontal) {
            HStack {
                ForEach(fonts,id: \.self) { font in
                    Text(font)
                        .font(.system(size: 14).bold())
                        .foregroundStyle(.gray.opacity(0.8))
                        .frame(width: 90)
                }
            }
            .padding()
        }
        .scrollIndicators(.hidden)
    }


    @ViewBuilder
    func colorView() -> some View  {

        VStack {
            HStack {
                ForEach(ColorOption.allCases,id:\.self) { option in

                    ArtText(option.title)
                }
            }
            .padding()

            HStack {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack {
                        ForEach(0..<10, id: \.self) { _ in
                            Circle()
                                .fill(Color.orange)
                                .frame(width: 50,height: 50)
                        }
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    func adjustView() -> some View  {

        VStack {

            HStack {
                ForEach(AdjustOption.allCases,id:\.self) {option in

                    ArtText(option.title)
                }
            }
            .padding()

            Slider(value: $sliderOption)
                .tint(.orange)
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    func canvasView() -> some View  {

        HStack {

            VStack{
                Slider(value: $sliderOption)
                    .tint(.orange)

                ArtText("Blur")

            }

            VStack{
                Slider(value: $sliderOption)
                    .tint(.orange)

                ArtText("Brightness")
            }

            Button {

            } label: {

                VStack {
                    ArtImage(systemName: "square.resize")
                    ArtText("Edit")
                }
            }
        }
        .padding()
    }

    @ViewBuilder
    func ArtText(_ title: String) -> some View {

        Text(title.uppercased())
            .font(.system(size: 13).bold())
            .foregroundStyle(.gray.opacity(0.8))
            .padding(.vertical, 3)
            .padding(.horizontal,8)
    }

    @ViewBuilder
    func ArtImage(systemName: String) -> some View {

        Image(systemName: systemName)
            .font(.system(size: 30))
            .foregroundStyle(.gray.opacity(0.8))
    }
}

#Preview {
    EditProjectView(item: .init(project: nil, folder: nil))
}
