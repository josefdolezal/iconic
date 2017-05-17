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

let main = command { (path: Path) in
    let fontParser = IconsFontFileParser()
    let environment = Environment(loader: FileSystemLoader(paths: ["Sources/Iconic/templates"]))

    try fontParser.parseFile(atUrl: path.url)

    let context = ["icons": fontParser.icons]
    let iconsEnum = try environment.renderTemplate(name: "default.stencil", context: context)

    print(iconsEnum)
}

main.run()
