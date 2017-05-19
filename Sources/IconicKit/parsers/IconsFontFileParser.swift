//
//  File.swift
//  Iconic
//
//  Created by Josef Dolezal on 17/05/2017.
//
//

import Foundation
import CoreText

enum IconsFontFileParserError: Error {
    case cannotReadFont(URL)
    case scalarUndefined(Int)
    case glyphNotAccessible(UniChar)
    case unknownName(CGGlyph)
}

public final class IconsFontFileParser: IconParsing {
    private(set) public var familyName: String? = ""

    private(set) public var icons = [Icon]()

    public init() { }

    public func parseFile(atUrl url: URL) throws {
        guard
            let descriptors = CTFontManagerCreateFontDescriptorsFromURL(url as CFURL),
            let descriptor = (descriptors as? [CTFontDescriptor])?.first
        else {
            throw IconsFontFileParserError.cannotReadFont(url)
        }

        let ctFont = CTFontCreateWithFontDescriptorAndOptions(descriptor, 0.0, nil, [.preventAutoActivation])

        familyName = CTFontCopyFamilyName(ctFont) as String
        icons = try extractGlyphs(fromFont: ctFont).sorted() { $0.name.compare($1.name) == .orderedAscending }
    }

    private func extractGlyphs(fromFont font: CTFont) throws -> [Icon] {
        let privateUseArea = 0xE000...0xF8FF
        let characterSet = CTFontCopyCharacterSet(font)
        let cgFont = CTFontCopyGraphicsFont(font, nil)

        // Examine all characters from Private Use Area (PUA)
        // Defined in https://en.wikipedia.org/wiki/Private_Use_Areas#Assignment
        return try privateUseArea.flatMap { unicode in
            guard
                let unicodeScalar = UnicodeScalar(unicode),
                let uniChar = UniChar(unicodeScalar.value) as UniChar?
            else {
                throw IconsFontFileParserError.scalarUndefined(unicode)
            }

            // Check if unicode character is member of charset
            if !CFCharacterSetIsCharacterMember(characterSet, uniChar) {
                return nil
            }

            var codePoint: [UniChar] = [uniChar]
            var glyphs: [CGGlyph] = [0, 0]

            // Gets the Glyph
            CTFontGetGlyphsForCharacters(font, &codePoint, &glyphs, 1)

            if glyphs.count == 0 {
                throw IconsFontFileParserError.glyphNotAccessible(uniChar)
            }

            // Gets the name of the Glyph, to be used as key
            guard let name = cgFont.name(for: glyphs[0]) else {
                throw IconsFontFileParserError.unknownName(glyphs[0])
            }

            return Icon(name: name as String, unicode: String(format: "%X", unicode))
        }
    }
}
