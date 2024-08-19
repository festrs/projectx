//
//  Previewer.swift
//
//
//  Created by Felipe Dias Pereira on 20/06/24.
//

import Foundation
import SwiftData
import Networking

@MainActor
struct Previewer {
    let container: ModelContainer
    let registry: Registry
    let ledger: Ledger

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Registry.self, configurations: config)
        ledger = Ledger(
            service: LedgerService(
                networking: NetworkService(host: "localhost")
            )
        )
        registry = Registry(name: "Test", code: "TT", price: 0.1, isSell: false)

        container.mainContext.insert(registry)
    }
}
