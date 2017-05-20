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
let outputOption = Option<Path>("output", "./", flag: "o", description: "The path to the file to generate (Omit to generate to current directory)"
) { path in
    // Allow only existing directory as valid output
    guard path.isDirectory else {
        throw ArgumentError.invalidType(value: path.description, type: "directory", argument: nil)
    }

    return path
}

// Input font path argument
let fontArgument = Argument<IconFont>("FONT FILE", description: "Font to parse.")

let main = command(outputOption, fontArgument) { output, font in
    let fontParser = IconsFontFileParser()
    let paths = IconicPaths(outputPath: output, font: font)
    let environment = Environment(iconicTemplatePaths: [paths.templatesSource])

    // Parse font glyphs into icons
    try fontParser.parseFile(atUrl: paths.fontPath.url)
    
    let context: [String: Any] = [
        "icons": fontParser.icons,
        "enumName": paths.iconsEnumName,
        "fontName": font.fontName,
        "fontPath": paths.catalogFontDestination.string,
        "familyName": fontParser.familyName ?? "unknown"
    ]

    // Render templates
    let iconsEnum = try environment.renderTemplate(name: paths.iconsTemplate, context: context)
    let catalog = try environment.renderTemplate(name: paths.catalogTemplate, context: context)
    let iconsInterface = try environment.renderTemplate(name: paths.iconsInterfaceTemplate)
    let interfaceBuilder = try environment.renderTemplate(name: paths.interfaceBuilderExtTemplate)

    // Create icons enum, html catalog and copy font file to output directory,
    // if file or already exists, it's overwritten,
    // see IconicPaths for more details
    try paths.iconsEnumDestination.clearBeforeAction { try $0.write(iconsEnum) }
    try paths.catalogDestination.clearBeforeAction { try $0.write(catalog) }
    try paths.catalogFontDestination.clearBeforeAction { try paths.fontPath.copyTo($0) }
    try paths.iconsInterfaceDestination.clearBeforeAction { try $0.write(iconsInterface) }
    try paths.interfaceBuilderExtDestination.clearBeforeAction { try $0.write(interfaceBuilder) }
}

main.run()
