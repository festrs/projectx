//
//  SymbolDetailViewModel.swift
//
//
//  Created by Felipe Dias Pereira on 04/07/24.
//

import Foundation

@Observable class SymbolDetailViewModel {
    @MainActor var isLoading: Bool = true
    @MainActor var quote: Quote?
    @ObservationIgnored let symbol: String
    @ObservationIgnored let service: ILedgerService

    init(symbol: String, service: ILedgerService) {
        self.symbol = symbol
        self.service = service
    }

    @MainActor func search() async {
        do {
            self.quote = try await service.search(symbol: symbol)
            print(Thread.current)
            isLoading = false
        } catch {
            isLoading = false
            print(error)
        }
    }
}
