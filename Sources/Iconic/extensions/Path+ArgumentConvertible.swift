//
//  Path+ArgumentConvertible.swift
//  Iconic
//
//  Created by Josef Dolezal on 17/05/2017.
//
//

import PathKit
import Commander

extension Path: ArgumentConvertible {
    public init(parser: ArgumentParser) throws {
        let string = try String(parser: parser)

        self.init(string)

        guard self.exists else {
            throw ArgumentError.invalidType(value: string, type: "path", argument: nil)
        }
    }
}
