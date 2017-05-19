//
//  IconFont.swift
//  Iconic
//
//  Created by Josef Dolezal on 19/05/2017.
//
//

import PathKit
import StencilSwiftKit
import Foundation

public enum IconFontError: Error {
    case unsupportedType(Path)
}

public struct IconFont {

    public enum FontType: String {
        case otf
        case ttf
    }

    public let path: Path

    public let type: FontType

    public let fontName: String

    public init(path: Path) throws {
        guard
            let fontExtension = path.extension,
            let type = FontType(rawValue: fontExtension)
        else {
            throw IconFontError.unsupportedType(path)
        }

        self.path = path
        self.type = type
        self.fontName = IconFont.normalizeFontName(path.lastComponentWithoutExtension)
    }

    public static func normalizeFontName(_ name: String) -> String {
        let trimmingCharacters = " -_–".characters
        var normalized = name

        // Splits and removes all substrings with the separator characters in the file name
        // like whitespaces, dash, underscore, etc.
        normalized = String(normalized.characters.filter{ !trimmingCharacters.contains($0) })

        // Specially, we want to strip the string starting from the word "Icon", and append it manually,
        // so a string like 'MaterialIconsFont' would look like 'MaterialIcon'.
        if let range = normalized.range(of: "icon", options: .caseInsensitive) {
            normalized = normalized.substring(to: range.lowerBound)
        }

        return normalized.uppercasedFirst()
    }
}

extension IconFont: CustomStringConvertible {
    public var description: String {
        return "IconFont {path: \(path.description), type: \(type.rawValue), fontName: \(fontName)}"
    }
}
