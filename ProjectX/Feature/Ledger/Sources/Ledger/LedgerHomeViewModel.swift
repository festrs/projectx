//
//  LedgerHomeViewModel.swift
//
//
//  Created by Felipe Dias Pereira on 26/06/24.
//

import Foundation
import SwiftUI
import Combine

@Observable
class LedgerHomeViewModel {
    var searchText: String = ""
    var filteredSymbols: [Symbol] = []
    @ObservationIgnored var symbols: [Symbol] = []
    @ObservationIgnored let service: ILedgerService
    @ObservationIgnored private var cancellables: Set<AnyCancellable> = []

    init(service: ILedgerService) {
        self.service = service
    }

    func loadSymbols() {
        guard symbols.isEmpty else { return }
        do {
            symbols = try service.loadSymbols()
        } catch {
            print(error)
        }
    }

    func search(keyword: String) {
        filteredSymbols = symbols.filter { $0.symbol.contains(keyword) }
    }
}
