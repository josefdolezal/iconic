//
//  Environment+IconicKit.swift
//  Iconic
//
//  Created by Josef Dolezal on 18/05/2017.
//
//

import PathKit
import Stencil
import StencilSwiftKit


public extension Environment {
    init(iconicTemplatePaths paths: [Path]) {
        let ext = Extension()

        ext.registerStencilSwiftExtensions()
        ext.registerFilter("unicodeCase", filter: IconicFilters.unicodeCase)

        self.init(loader: FileSystemLoader(paths: paths), extensions: [ext], templateClass: StencilSwiftTemplate.self)
    }
}
