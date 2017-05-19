//
//  String+IconicKit.swift
//  Iconic
//
//  Created by Josef Dolezal on 19/05/2017.
//
//

import Foundation

extension String {
    func uppercasedFirst() -> String {
        var modified = self

        // Range of first character
        let range = startIndex...startIndex

        // Modify only non-empty strings
        if let character = characters.first {
            modified.replaceSubrange(range, with: String(character))
            return modified
        }

        return self
    }
}
