//
//  Ledger.swift
//
//
//  Created by Felipe Dias Pereira on 08/07/24.
//

import Foundation
import SwiftUI

@Observable class Ledger {
    var searchResult: SearchResult?
    var quote: Quote?
    var searchString = "" {
        didSet {
//            Task {
//                guard searchString.isEmpty == false else { return }
//                await search(query: searchString)
//            }
        }
    }
//    var searchSuggestions: [Symbol] {
//        Symbol.allSymbols.filter {
//            $0.symbol.localizedCaseInsensitiveContains(searchString) &&
//            $0.symbol.localizedCaseInsensitiveCompare(searchString) != .orderedSame
//        }
//    }    
    @ObservationIgnored let service: ILedgerService

    init(service: ILedgerService) {
        self.service = service
    }
}

extension Ledger {
    @MainActor func fetchQuote(symbol: String) async -> Quote? {
        do {
            return try await service.quote(symbol: symbol)
        } catch {
            print(error)
            return nil
        }
    }

    @MainActor func search(query: String) async {
        print("search string = \(query)")
        guard query.isEmpty == false else {
            searchResult = nil
            return
        }
        do {
            print("call - backend")
            searchResult = try await service.search(query: query)
        } catch {
            searchResult = nil
            print(error)
        }
    }
}
