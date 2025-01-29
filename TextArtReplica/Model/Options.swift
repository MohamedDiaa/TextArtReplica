//
//  Options.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-29.
//

enum EditOption: CaseIterable {
    case style
    case color
    case adjust
    case canvas

    var icon: String {
        switch self {
        case .style: return "textformat.alt.el"
        case .color: return "paintpalette.fill"
        case .adjust: return "slider.horizontal.3"
        case .canvas: return "distribute.horizontal.right"
        }
    }

    var title: String {
        switch self {
        case .style: return "Style"
        case .color: return "Color"
        case .adjust: return "Adjust"
        case .canvas: return "Canvas"
        }
    }
}

enum ColorOption: CaseIterable {
    case color
    case gradient
    case pattern
    case invert

    var title: String {
        switch self {
        case .color: return "Color"
        case .gradient: return "Gradient"
        case .pattern: return "Pattern"
        case .invert: return "Invert"
        }
    }
}

enum AdjustOption: CaseIterable {

    case shadow, opacity, eraser

    var title:String {
        switch self {
        case .shadow: return "Shadow"
        case .opacity: return "Opacity"
        case .eraser: return "Eraser"
        }
    }
}
