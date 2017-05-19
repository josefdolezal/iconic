//
//  IconFont.swift
//  Iconic
//
//  Created by Josef Dolezal on 19/05/2017.
//
//

import PathKit

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

    public init(path: Path) throws {
        guard
            let fontExtension = path.extension,
            let type = FontType(rawValue: fontExtension)
        else {
            throw IconFontError.unsupportedType(path)
        }

        self.path = path
        self.type = type
    }
}

extension IconFont: CustomStringConvertible {
    public var description: String {
        return path.description
    }
}
