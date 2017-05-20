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

struct IconicPaths {
    let iconsTemplate: String

    let catalogTemplate: String

    let enumName: String

    let outputPath: Path

    let fontPath: Path

    let templatesSource: Path

    let commonFilesSource: Path

    let iconsEnumDestination: Path

    let catalogDestination: Path

    let catalogFontDestination: Path

    let commonFilesDestination: Path

    init(outputPath: Path, font: IconFont) {
        let fontFile = font.path.lastComponent
        let commonComponentsDirectory = Path("IconicCommon")

        self.enumName = "\(font.fontName)Icon"
        self.iconsTemplate = "iconic-default.stencil"
        self.catalogTemplate = "catalog.stencil"
        self.outputPath = outputPath
        self.fontPath = font.path
        self.templatesSource = Path("./templates")
        self.commonFilesSource = templatesSource + commonComponentsDirectory
        self.iconsEnumDestination = outputPath + Path("\(enumName).swift")
        self.catalogDestination = outputPath + Path("\(enumName)Catalog.html")
        self.catalogFontDestination = outputPath + Path(fontFile)
        self.commonFilesDestination = outputPath + commonComponentsDirectory
    }
}
