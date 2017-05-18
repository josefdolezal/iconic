//
//  main.swift
//  Iconic
//
//  Created by Josef Dolezal on 17/05/2017.
//
//

import Commander
import PathKit
import IconicKit
import Stencil
import StencilSwiftKit

let outputOption = Option<Path>("output", "./", flag: "o", description: "The path to the file to generate (Omit to generate to stdout)"
) { path in

    guard path.isDirectory else {
        throw ArgumentError.invalidType(value: path.description, type: "directory", argument: nil)
    }

    return path
}

let fontArgument = Argument<Path>("FONT FILE", description: "Font to parse.") { path in
    guard path.isFile else {
        throw ArgumentError.invalidType(value: path.description, type: "file", argument: nil)
    }

    return path
}

let main = command(outputOption, fontArgument) { output, fontPath in
    let fontOutput = output + Path("FontAwesomeIcon.swift")
    let catalogOutput = output + Path("FontAwesomeCatalog.html")
    let catalogFontOutput = output + fontPath.lastComponent

    let fontParser = IconsFontFileParser()
    let environment = Environment(iconicTemplatePaths: ["./templates"])

    try fontParser.parseFile(atUrl: fontPath.url)
    
    let context: [String: Any] = [
        "icons": fontParser.icons,
        "enumName": "FontAwesomeIcon",
        "fontName": "FontAwesome",
        "fontPath": "/Users/josef/Developer/Git/Projects/Iconic/FontAwesome.otf"
    ]

    let iconsEnum = try environment.renderTemplate(name: "iconic-default.stencil", context: context)
    let catalog = try environment.renderTemplate(name: "catalog.stencil", context: context)

    // Create icons enum, html catalog and copy font file to output directory
    try fontOutput.write(iconsEnum)
    try catalogOutput.write(catalog)
    try fontPath.copy(catalogFontOutput)
}

main.run()
