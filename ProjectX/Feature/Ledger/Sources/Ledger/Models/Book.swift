//
//  Book.swift
//
//
//  Created by Felipe Dias Pereira on 20/06/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var registries: [Registry]

    init() {
        self.registries = []
    }
}
