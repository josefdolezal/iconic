//
//  IconParsing.swift
//  Iconic
//
//  Created by Josef Dolezal on 17/05/2017.
//
//

import Foundation

public protocol IconParsing {
    var familyName: String? { get }

    var icons: [Icon] { get }

    func parseFile(atUrl url: URL) throws
}
