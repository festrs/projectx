//
//  SearchResult.swift
//
//
//  Created by Felipe Dias Pereira on 15/07/24.
//

import Foundation
import Combine

class Search: ObservableObject {
    @Published var queryString: String = ""
    @Published var text: String = ""
    private var cancellables = Set<AnyCancellable>()

    init() {
        $text
            .removeDuplicates()
            .throttle(for: .seconds(0.8), scheduler: DispatchQueue.main, latest: true)
            .sink { [weak self] value in
                self?.queryString = value
            }.store(in: &cancellables)
    }
}

// MARK: - SearchResult
struct SearchResult: Decodable {
    let count: Int
    let quotes: [SearchResult.Quote]
    let news: [News]

    enum CodingKeys: CodingKey {
        case count
        case quotes
        case news
    }
}

extension SearchResult {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        count = try container.decode(Int.self, forKey: .count)
        let quotes = try container.decode([OptionalObject<Quote>].self, forKey: .quotes)
        self.quotes = quotes.compactMap { $0.value }
        news = try container.decode([News].self, forKey: .news)
    }
}

// MARK: - News
struct News: Decodable, Identifiable {
    var id: UUID { return uuid }
    let uuid: UUID
    let title, publisher: String
    let link: String
    let providerPublishTime, type: String
    let thumbnail: Thumbnail?
    let relatedTickers: [String]?

    enum CodingKeys: CodingKey {
        case uuid
        case title
        case publisher
        case link
        case providerPublishTime
        case type
        case thumbnail
        case relatedTickers
    }
}

extension News {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        uuid = try container.decode(UUID.self, forKey: .uuid)
        title = try container.decode(String.self, forKey: .title)
        link = try container.decode(String.self, forKey: .link)
        publisher = try container.decode(String.self, forKey: .publisher)
        providerPublishTime = try container.decode(String.self, forKey: .providerPublishTime)
        type = try container.decode(String.self, forKey: .type)
        thumbnail = try container.decodeIfPresent(Thumbnail.self, forKey: .thumbnail)
        relatedTickers = try container.decodeIfPresent([String].self, forKey: .relatedTickers)
    }
}

extension News {
    // MARK: - Thumbnail
    struct Thumbnail: Decodable {
        let resolutions: [Resolution]
    }
}

extension News.Thumbnail {
    // MARK: - Resolution
    struct Resolution: Decodable {
        let url: String
        let width, height: Int
        let tag: String
    }
}


extension SearchResult {

    // MARK: - Quote
    struct Quote: Decodable, Identifiable {
        var id: String { return UUID().uuidString }
        let shortname: String
        let symbol: String
        let longname: String?
        let name: String?

        enum CodingKeys: CodingKey {
            case shortname
            case symbol
            case longname
            case name
        }
    }
}

extension SearchResult.Quote {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: SearchResult.Quote.CodingKeys.self)
        self.shortname = try container.decode(String.self, forKey: SearchResult.Quote.CodingKeys.shortname)
        self.symbol = try container.decode(String.self, forKey: SearchResult.Quote.CodingKeys.symbol)
        self.longname = try container.decodeIfPresent(String.self, forKey: SearchResult.Quote.CodingKeys.longname)
        self.name = try container.decodeIfPresent(String.self, forKey: SearchResult.Quote.CodingKeys.name)
    }
}


public struct OptionalObject<Base: Decodable>: Decodable {
    public let value: Base?

    public init(from decoder: Decoder) throws {
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
}


#if DEBUG

extension SearchResult.Quote {
    static let apple: Self = .init(shortname: "Apple Inc.", symbol: "AAPL", longname: "Apple Inc.", name: "Apple Inc.")
    static let bbse: Self = .init(shortname: "BB Seguridade", symbol: "BBSEY", longname: "BB Seguridade", name: "BB Seguridade")
}

#endif
