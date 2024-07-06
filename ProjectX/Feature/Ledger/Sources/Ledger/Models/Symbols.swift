//
//  Symbol.swift
//  
//
//  Created by Felipe Dias Pereira on 01/07/24.
//

import Foundation

struct Symbol: Decodable, Identifiable {
    var id: String { symbol }
    var symbol: String
    var name: String
}
