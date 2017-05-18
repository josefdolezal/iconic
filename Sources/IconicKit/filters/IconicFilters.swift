//
//  IconicFilters.swift
//  Iconic
//
//  Created by Josef Dolezal on 18/05/2017.
//
//

import Foundation
import Stencil

struct IconicFilters {
    enum Error: Swift.Error {
        case invalidInputType
    }

    static func unicodeCase(value: Any?) throws -> Any? {
        guard let string = value as? String else {
            throw IconicFilters.Error.invalidInputType
        }
        return unicodeCase(for: string)
    }

    private static func unicodeCase(for string: String) -> String {
        let escapingCharacterSet = CharacterSet(charactersIn: "\\")
        let unicode = string.trimmingCharacters(in: escapingCharacterSet)

        let newString = "\\u{\(unicode)}"

        return newString
    }
}
