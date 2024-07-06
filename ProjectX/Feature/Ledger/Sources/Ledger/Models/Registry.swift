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
    var name: String
    var code: String
    var price: Decimal
    var isSell: Bool

    internal init(createdDate: Date, name: String, code: String, price: Decimal, isSell: Bool) {
        self.createdDate = createdDate
        self.name = name
        self.code = code
        self.price = price
        self.isSell = isSell
    }
}
