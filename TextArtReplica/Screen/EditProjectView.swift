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

class AddedText: ObservableObject {
    @Published var title: String = "Hello world"
    @Published var offset: CGSize = .zero
    @Published var font: String = ""
    @Published var fontSize: CGFloat = 40
    @Published var foregroundColor: Color = .white
    @Published var rotation: Angle = .zero
}

struct EditProjectView: View {

    @Bindable var item: ModelItem
    @State private var editOptionSelected: EditOption = .style
    @State private var selectedColorType: ColorOption = .color

    @State var sliderOption: CGFloat = 0.3

    @StateObject var added: AddedText = .init()

    var body: some View {

        VStack {
            VStack {
                if let name = item.project?.name  {
                    GeometryReader { proxy in

                        ZStack {
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)

                            Text(added.title)
                                .font(.system(size: added.fontSize).bold())
                                .foregroundStyle(added.foregroundColor)
                                .padding()
                                .background(Rectangle().stroke(.white, lineWidth: 2))
                                .overlay(alignment: .topTrailing) {
                                    Button {

                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .font(.system(size: 30))
                                            .offset(x: 10, y: -10)
                                            .foregroundStyle(.white)
                                    }
                                }
                                .overlay(alignment: .bottom) {
                                    Button {

                                    } label: {

                                        Image(systemName: "pencil.circle.fill")
                                            .font(.system(size: 30))
                                            .offset(y: 20)
                                            .foregroundStyle(.white)
                                    }
                                }
                                .rotationEffect(added.rotation)
                                .offset(added.offset)
                        }

                    }
                    .gesture(

                        DragGesture().onChanged({ change in

                            added.offset = change.translation
                        }).simultaneously(
                            with: RotateGesture().onChanged({ change in

                                added.rotation = change.rotation
                            })
                        )
                        .simultaneously(
                            with:  MagnifyGesture().onChanged({ change in

                                // print("magnification \(change.magnification)")
                                added.fontSize =  40 * change.magnification + 3
                            })
                        )
                    )

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
        .toolbar(content: {
            ToolbarItemGroup(placement: .topBarLeading) {

                Button {

                } label: {
                    ArtImage(systemName: "plus")
                        .foregroundStyle(.orange)
                }

            }
        })
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
