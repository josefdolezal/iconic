//
//  IconsJSONFileParser.swift
//  Iconic
//
//  Created by Josef Dolezal on 17/05/2017.
//
//

import Foundation

enum IconsJSONFileParserError: Error {
    case invalidJSON(Any)
}

public final class IconsJSONFileParser: IconParsing {

    public var familyName: String?
    public var icons = [Icon]()

    public init() {}

    public func parseFile(atUrl url: URL) throws {
        let JSONData = try Data(contentsOf: url)
        let json = try JSONSerialization.jsonObject(with: JSONData, options: [])

        guard let dictionary = json as? [String: String] else {
            throw IconsJSONFileParserError.invalidJSON(json)
        }

        icons = dictionary.map({ name, hexCode in
            return Icon(name: name, unicode: hexCode)
        })
    }
}
