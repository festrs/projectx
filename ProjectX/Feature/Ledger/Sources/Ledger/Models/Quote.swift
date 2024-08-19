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
    let regularMarketOpen: Double
    let regularMarketDayRange: Range
    let regularMarketChangePercent: Double
    let regularMarketChange: Double
    let fiftyTwoWeekRange: Range
    let shortName, longName: String
    let bookValue: Double?
    let dividendYield: Double?
    let bid: Double
    let ask: Double
    let bidSize: Int
    let askSize: Int
    let fullExchangeName: String
    let financialCurrency: String
    let symbol: String

    enum CodingKeys: CodingKey {
        case quoteType
        case currency, exchange
        case market
        case regularMarketPrice
        case regularMarketOpen
        case regularMarketDayRange
        case regularMarketChangePercent
        case regularMarketChange
        case fiftyTwoWeekRange
        case shortName, longName
        case bookValue
        case dividendYield
        case bid, ask
        case bidSize, askSize
        case fullExchangeName, financialCurrency
        case symbol
    }

    // MARK: - Range
    struct Range: Codable {
        let low, high: Double
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
        regularMarketOpen = try container.decode(Double.self, forKey: .regularMarketOpen)
        regularMarketDayRange = try container.decode(Range.self, forKey: .regularMarketDayRange)
        regularMarketChangePercent = try container.decode(Double.self, forKey: .regularMarketChangePercent)
        regularMarketChange = try container.decode(Double.self, forKey: .regularMarketChange)        
        shortName = try container.decode(String.self, forKey: .shortName)
        longName = try container.decode(String.self, forKey: .longName)
        bookValue = try container.decodeIfPresent(Double.self, forKey: .bookValue)
        dividendYield = try container.decodeIfPresent(Double.self, forKey: .dividendYield)
        bid = try container.decode(Double.self, forKey: .bid)
        bidSize = try container.decode(Int.self, forKey: .bidSize)
        ask = try container.decode(Double.self, forKey: .ask)
        askSize = try container.decode(Int.self, forKey: .askSize)
        fullExchangeName = try container.decode(String.self, forKey: .fullExchangeName)
        financialCurrency = try container.decode(String.self, forKey: .financialCurrency)
        symbol = try container.decode(String.self, forKey: .symbol)
        fiftyTwoWeekRange = try container.decode(Range.self, forKey: .fiftyTwoWeekRange)
    }
}

extension Quote {
    struct Presenter {
        
    }
}
