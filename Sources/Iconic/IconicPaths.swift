//
//  IconicPaths.swift
//  Iconic
//
//  Created by Josef Dolezal on 20/05/2017.
//
//

import Foundation
import IconicKit
import PathKit

// Source directory structure:
//
// -- Swift PM --
//
//  Iconic
//  templates/
//      ├── catalog.stencil
//      ├── iconic-default.stencil
//      ├── IconDrawable.stencil
//      └── IconImageView.stencil
//
// -- When building with Xcode (flattened) --
//
//  Iconic
//  catalog.stencil
//  iconic-default.stencil
//  IconDrawable.stencil
//  IconImageView.stencil
//
// Destination directory structure:
//
//  output/
//      ├── Font.otf
//      ├── FontIcon.swift
//      ├── FontCatalog.html
//      ├── IconDrawable.swift
//      └── IconImageView.swift

struct IconicPaths {
    let iconsEnumName: String

    // MARK: User-specified data

    let outputPath: Path

    let fontPath: Path

    // MARK: Iconic templates source

    let templatesSource: Path

    let iconsTemplate: String

    let catalogTemplate: String

    let iconsInterfaceTemplate: String

    let interfaceBuilderExtTemplate: String

    // MARK: Destination of files located in `output` directory

    let iconsEnumDestination: Path

    let catalogDestination: Path

    let catalogFontDestination: Path

    let iconsInterfaceDestination: Path

    let interfaceBuilderExtDestination: Path

    init(outputPath: Path, font: IconFont) {
        // Get path of folder where the binary is stored
        let binPath = Path(ProcessInfo.processInfo.arguments[0]).parent()

        let fontFile = Path(font.path.lastComponent)

        // Template names
        self.iconsTemplate = "iconic-default.stencil"
        self.catalogTemplate = "catalog.stencil"
        self.iconsInterfaceTemplate = "IconDrawable.stencil"
        self.interfaceBuilderExtTemplate = "IconImageView.stencil"

        self.iconsEnumName = "\(font.fontName)Icon"
        self.outputPath = outputPath
        self.fontPath = font.path

        // Load sources re
        self.templatesSource = binPath + Path(IconicPaths.flattenIfNeeded(destination: "./templates"))

        self.iconsEnumDestination = outputPath + Path("\(iconsEnumName).swift")
        self.catalogDestination = outputPath + Path("\(iconsEnumName)Catalog.html")
        self.catalogFontDestination = outputPath + fontFile
        self.iconsInterfaceDestination = outputPath + Path("IconDrawable.swift")
        self.interfaceBuilderExtDestination = outputPath + Path("IconImageView.swift")
    }

    // Add support for Xcode builds
    static func flattenIfNeeded(destination: String, flattened: String = "./") -> String {
        return Bundle.main.path(forResource: destination, ofType: nil) ?? flattened
    }
}
