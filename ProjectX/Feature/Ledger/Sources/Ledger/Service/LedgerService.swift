//
//  LedgerService.swift
//
//
//  Created by Felipe Dias Pereira on 26/06/24.
//

import Foundation
@preconcurrency import Networking

extension Endpoint {
    static func search(query: String) -> Endpoint {
        .init(path: "/search", method: .get, scheme: "http", port: 3000, urlQueries: ["query": query])
    }

    static func quote(symbol: String) -> Endpoint {
        .init(path: "/quote", method: .get, scheme: "http", port: 3000, urlQueries: ["symbol": symbol])
    }
}

protocol ILedgerService: Sendable {
    func search(query: String) async throws -> SearchResult
    func quote(symbol: String) async throws -> Quote
    func loadSymbols() throws -> [Symbol]
}

final class LedgerService: ILedgerService {
    let apiClientService: NetworkService
    let decoder: JSONDecoder

    init(networking: NetworkService) {
        self.apiClientService = networking
        self.decoder = JSONDecoder()
    }

    func search(query: String) async throws -> SearchResult {
        try await apiClientService.request(for: .search(query: query))
    }

    func quote(symbol: String) async throws -> Quote {
        try await apiClientService.request(for: .quote(symbol: symbol))
    }

    func loadSymbols() throws -> [Symbol] {
        guard let resourceUrl = Bundle.module.url(
          forResource: "symbols",
          withExtension: "json"
        ) else {
            throw Errors.cannotFindResource
        }

        let resourceData = try Data(contentsOf: resourceUrl)
        let symbols = try decoder.decode([Symbol].self, from: resourceData)
        return symbols
    }
}

extension LedgerService {
    enum Errors: LocalizedError {
        case cannotFindResource
    }
}
