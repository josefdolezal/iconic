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

// Output folder option
let outputOption = Option<Path>("output", "./", flag: "o", description: "The path to the file to generate (Omit to generate to stdout)"
) { path in

    guard path.isDirectory else {
        throw ArgumentError.invalidType(value: path.description, type: "directory", argument: nil)
    }

    return path
}

// Input font path argument
let fontArgument = Argument<IconFont>("FONT FILE", description: "Font to parse.")

let main = command(outputOption, fontArgument) { output, font in
    // Actual Icon enum name
    let enumName = "\(font.fontName)Icon"
    // Path of original font file
    let fontPath = font.path
    // Generated enum path
    let fontOutput = output + Path("\(enumName).swift")
    // Generated html catalog path
    let catalogOutput = output + Path("\(enumName)Catalog.html")
    // Path of font used in html catalog
    let catalogFontOutput = output + fontPath.lastComponent

    let fontParser = IconsFontFileParser()
    let environment = Environment(iconicTemplatePaths: ["./templates"])

    try fontParser.parseFile(atUrl: fontPath.url)
    
    let context: [String: Any] = [
        "icons": fontParser.icons,
        "enumName": enumName,
        "fontName": font.fontName,
        "fontPath": catalogFontOutput.string
    ]

    let iconsEnum = try environment.renderTemplate(name: "iconic-default.stencil", context: context)
    let catalog = try environment.renderTemplate(name: "catalog.stencil", context: context)

    // Create icons enum, html catalog and copy font file to output directory,
    // if file already exists, it's overwritten
    try fontOutput.clearBeforeAction { try $0.write(iconsEnum) }
    try catalogOutput.clearBeforeAction { try $0.write(catalog) }
    try catalogFontOutput.clearBeforeAction { try fontPath.copy($0) }
}

main.run()
