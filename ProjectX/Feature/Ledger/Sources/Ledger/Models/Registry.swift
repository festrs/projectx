//
//  Registry.swift
//
//
//  Created by Felipe Dias Pereira on 20/06/24.
//

import Foundation
import SwiftData

@Model
class Registry {
    var createdDate: Date
    let name: String
    let code: String
    var price: Decimal
    var isSell: Bool

    init(name: String, code: String, price: Decimal, isSell: Bool) {
        self.createdDate = Date()
        self.name = name
        self.code = code
        self.price = price
        self.isSell = isSell
    }
}
