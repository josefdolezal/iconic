//
//  IconFont+ArgumentConvertible.swift
//  Iconic
//
//  Created by Josef Dolezal on 19/05/2017.
//
//

import Commander
import PathKit
import IconicKit

extension IconFont: ArgumentConvertible {
    public init(parser: ArgumentParser) throws {
        let path = try Path(parser: parser)

        do {
            try self.init(path: path)
        } catch {
            throw ArgumentError.invalidType(value: path.description, type: "otf or ttf font file", argument: nil)
        }
    }
}
