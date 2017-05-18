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

let main = command { (path: Path) in
    let fontParser = IconsFontFileParser()
    let environment = Environment(iconicTemplatePaths: ["./templates"])

    try fontParser.parseFile(atUrl: path.url)
    
    let context: [String: Any] = [
        "icons": fontParser.icons,
        "enumName": "FontAwesomeIcon",
        "fontName": "FontAwesome",
        "fontPath": "/Users/josef/Developer/Git/Projects/Iconic/FontAwesome.otf"
    ]

    let iconsEnum = try environment.renderTemplate(name: "iconic-default.stencil", context: context)
    let catalog = try environment.renderTemplate(name: "catalog.stencil", context: context)

    // print(iconsEnum)
    print(catalog)
}

main.run()
