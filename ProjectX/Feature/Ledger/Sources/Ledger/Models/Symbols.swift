//
//  Symbol.swift
//  
//
//  Created by Felipe Dias Pereira on 01/07/24.
//

import Foundation

struct Symbol: Codable, Identifiable {
    var id: String { isin }
    var symbol: String
    var name: String
    var isin: String

    enum CodingKeys: CodingKey {
        case symbol
        case name
        case isin
    }
}

extension Symbol: Hashable {

}

extension Symbol {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try container.decode(String.self, forKey: .symbol)
        name = try container.decode(String.self, forKey: .name)
        let isin = try container.decodeIfPresent(String.self, forKey: .isin)
        if let isin {
            self.isin = isin
        } else {
            self.isin = "ERROR"
        }
    }
}

extension Symbol {
    static let allSymbols: [Symbol] = {
        guard let resourceUrl = Bundle.module.url(
          forResource: "symbols",
          withExtension: "json"
        ) else {
            return []
        }
        guard let resourceData = try? Data(contentsOf: resourceUrl) else { return [] }
        let symbols = try? JSONDecoder().decode([Symbol].self, from: resourceData)        
        return symbols ?? []
    }()
}


#if DEBUG

extension Symbol {
    static let apple: Self = .init(
        symbol: "AAPL",
        name: "Apple inc",
        isin: "123"
    )

    static let bbse: Self = .init(
        symbol: "BBSE3.SA",
        name: "Brasil",
        isin: "1234"
    )
}

#endif
