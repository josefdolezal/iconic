//
//  Path+Iconic.swift
//  Iconic
//
//  Created by Josef Dolezal on 19/05/2017.
//
//

import PathKit

extension Path {
    func clearBeforeAction(action: (Path) throws -> Void) throws {
        if exists {
            try delete()
        }

        try action(self)
    }

    func copyTo(_ destination: PathKit.Path) throws {
        try copy(destination)
    }
}
