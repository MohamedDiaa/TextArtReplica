//
//  Options.swift
//  TextArtReplica
//
//  Created by Mohamed Alwakil on 2025-01-29.
//


//// ["Copperplate", "Heiti SC", "Iowan Old Style", "Kohinoor Telugu", "Thonburi", "Heiti TC", "Courier New", "Gill Sans", "Apple SD Gothic Neo", "Marker Felt", "Avenir Next Condensed", "Tamil Sangam MN", "Helvetica Neue", "Gurmukhi MN", "Times New Roman", "Georgia", "Apple Color Emoji", "Arial Rounded MT Bold", "Kailasa", "Kohinoor Devanagari", "Kohinoor Bangla", "Chalkboard SE", "Sinhala Sangam MN", "PingFang TC", "Gujarati Sangam MN", "Damascus", "Noteworthy", "Geeza Pro", "Avenir", "Academy Engraved LET", "Mishafi", "Futura", "Farah", "Kannada Sangam MN", "Arial Hebrew", "Arial", "Party LET", "Chalkduster", "Hoefler Text", "Optima", "Palatino", "Lao Sangam MN", "Malayalam Sangam MN", "Al Nile", "Bradley Hand", "PingFang HK", "Trebuchet MS", "Helvetica", "Courier", "Cochin", "Hiragino Mincho ProN", "Devanagari Sangam MN", "Oriya Sangam MN", "Snell Roundhand", "Zapf Dingbats", "Bodoni 72", "Verdana", "American Typewriter", "Avenir Next", "Baskerville", "Khmer Sangam MN", "Didot", "Savoye LET", "Bodoni Ornaments", "Symbol", "Menlo", "Bodoni 72 Smallcaps", "Papyrus", "Hiragino Sans", "PingFang SC", "Euphemia UCAS", "Telugu Sangam MN", "Bangla Sangam MN", "Zapfino", "Bodoni 72 Oldstyle"]


struct StyleOption: Hashable {
    var style: String
    var title: String
}


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
