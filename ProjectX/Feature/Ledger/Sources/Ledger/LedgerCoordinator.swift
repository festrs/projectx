//
//  LedgerCoordinator.swift
//
//
//  Created by Felipe Dias Pereira on 21/06/24.
//

import SwiftUI
import Router
import Networking

public struct LedgerCoordinator: View {
    @EnvironmentObject private var router: Router
    var networking: NetworkService

    public init() { 
        networking = NetworkService(host: "localhost")
    }

    public var body: some View {
        LedgerHome(
            viewModel:
                LedgerHomeViewModel(
                    service: LedgerService(
                        networking: networking
                    )
                )
        )
        .navigationDestination(for: Registry.self) { registry in
            EditRegistry(registry: registry)
        }
        .modelContainer(for: Registry.self)
    }
}

#Preview {
    @StateObject var router = Router()

    return NavigationStack(path: $router.navPath) {
        LedgerCoordinator()
    }
    .environmentObject(router)
}
