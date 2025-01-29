//
//  EditProjectView.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-28.
//

import SwiftUI
import SwiftData


var styleList: [StyleOption] = [
    .init(style: "Times New Roman", title: "Filled\nTo\nThe\nBRIM"),
    .init(style: "Copperplate", title: "Modern\nTimes"),
    .init(style: "Zapfino", title: "mark"),
    .init(style: "American Typewriter", title: "The\nMODERN\nDAYS"),
    .init(style: "Bodoni 72 Oldstyle", title: "Just My\nType"),
]
var colorList: [Color] = [
    .blue, .gray,  .white, .red, .green,
    .cyan, .yellow, .mint, .orange, .purple, .brown,
]

class OverlayText: ObservableObject {
    @Published var title: String = "Hello world"
    @Published var style: String = "Copperplate"
    @Published var offset: CGSize = .zero
    @Published var font: String = ""
    @Published var fontSize: CGFloat = 40
    @Published var foregroundColor: Color = .white
    @Published var rotation: Angle = .zero
    @Published var shadow: CGFloat = .zero
    @Published var opacity: CGFloat = 1.0
    @Published var blur: CGFloat = 0
    @Published var brightness: CGFloat = 0
}

struct EditProjectView: View {

    @Bindable var item: ModelItem
    @State private var editOptionSelected: EditOption = .style
    @State private var colorOption: ColorOption = .color
    @State private var adjustOption: AdjustOption = .opacity

    @State var sliderOption: CGFloat = 0.3

    @StateObject var added: OverlayText = .init()

    var body: some View {

        VStack {
            VStack {
                if let name = item.project?.name  {
                    GeometryReader { proxy in

                        ZStack {
                            Image(name)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .blur(radius: added.blur)
                                .brightness(added.brightness)
                        OverLayText(added)
                        }
                    }
                    .gesture(

                        DragGesture().onChanged({ change in

                            added.offset = change.translation
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
    func OverLayText(_ overlay: OverlayText) -> some View {

        Text(overlay.title)
            .font(.custom(overlay.style, size: overlay.fontSize))
//            .font(.system(size: overlay.fontSize).bold())
            .foregroundStyle(overlay.foregroundColor)
            .shadow(color: .gray, radius: overlay.shadow)
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
            .opacity(overlay.opacity)
            .rotationEffect(overlay.rotation)
            .offset(overlay.offset)
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
                ForEach(styleList,id: \.self) { option in

                    Button {
                        added.style = option.style
                    } label: {
                        Text(option.title)
                            .font(.system(size: 14).bold())
                            .foregroundStyle(added.style == option.style ? .black : .gray.opacity(0.8))
                            .frame(width: 90)
                    }
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

                    Button {
                        colorOption = option
                    } label: {
                        ArtText(option.title, selected: colorOption == option)
                    }
                }
            }
            .padding()

            HStack {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 10){
                        ForEach(colorList, id: \.self) {option in

                            Button {
                                added.foregroundColor = option
                            } label: {
                                Circle()
                                    .stroke(.gray.opacity(0.5), lineWidth: 2)
                                    .fill(option)
                                    .frame(width: 50,height: 50)
                            }
                        }
                    }
                    .padding(.vertical, 5)
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
                    Button {
                        adjustOption = option

                    } label: {
                        ArtText(option.title, selected: adjustOption == option)
                    }
                }
            }
            .padding()

            switch adjustOption {
            case .shadow:
                Slider(value: $added.shadow, in: 0...20, step: 2)
                    .tint(.orange)

            case .opacity:
                Slider(value: $added.opacity)
                    .tint(.orange)
            case .eraser:
                Slider(value: .constant(0.5))
                    .tint(.orange)
            }
        }
        .frame(maxWidth: .infinity)
    }

    @ViewBuilder
    func canvasView() -> some View  {

        HStack {

            VStack{
                Slider(value: $added.blur, in: 0...8, step: 1)
                    .tint(.orange)

                ArtText("Blur")
            }

            VStack{
                Slider(value: $added.brightness,in: -1...1, step: 0.2)
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
    func ArtText(_ title: String, selected: Bool = false) -> some View {

        Text(title.uppercased())
            .font(.system(size: 13).bold())
            .foregroundStyle(selected ? .white : .gray.opacity(0.8))
            .padding(.vertical, 3)
            .padding(.horizontal,8)
            .background(selected ? Capsule().fill(.black) : Capsule().fill(.clear))
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
