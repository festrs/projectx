//
//  Quote.swift
//
//
//  Created by Felipe Dias Pereira on 26/06/24.
//

import Foundation

struct Quote: Decodable {
    let quoteType: String
    let currency, exchange: String
    let market: String
    let regularMarketPrice: Double
    let shortName, longName: String
    let bookValue: Double
    let dividendYield: Double
    let bid, ask: Double
    let fullExchangeName, financialCurrency: String
    let symbol: String

    enum CodingKeys: CodingKey {
        case quoteType
        case currency, exchange
        case market
        case regularMarketPrice
        case shortName, longName
        case bookValue
        case dividendYield
        case bid, ask
        case fullExchangeName, financialCurrency
        case symbol
    }
}

extension Quote {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        quoteType = try container.decode(String.self, forKey: .quoteType)
        currency = try container.decode(String.self, forKey: .currency)
        exchange = try container.decode(String.self, forKey: .exchange)
        market = try container.decode(String.self, forKey: .market)
        regularMarketPrice = try container.decode(Double.self, forKey: .regularMarketPrice)
        shortName = try container.decode(String.self, forKey: .shortName)
        longName = try container.decode(String.self, forKey: .longName)
        bookValue = try container.decode(Double.self, forKey: .bookValue)
        dividendYield = try container.decode(Double.self, forKey: .dividendYield)
        bid = try container.decode(Double.self, forKey: .bid)
        ask = try container.decode(Double.self, forKey: .ask)
        fullExchangeName = try container.decode(String.self, forKey: .fullExchangeName)
        financialCurrency = try container.decode(String.self, forKey: .financialCurrency)
        symbol = try container.decode(String.self, forKey: .symbol)
    }
}
