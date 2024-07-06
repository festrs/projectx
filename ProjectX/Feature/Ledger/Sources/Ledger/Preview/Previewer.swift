//
//  Previewer.swift
//
//
//  Created by Felipe Dias Pereira on 20/06/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let registry: Registry

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Registry.self, configurations: config)

        registry = Registry(createdDate: Date(), name: "Test", code: "TT", price: 0.1, isSell: false)

        container.mainContext.insert(registry)
    }
}

