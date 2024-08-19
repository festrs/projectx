//
//  LedgerCoordinator.swift
//
//
//  Created by Felipe Dias Pereira on 21/06/24.
//

import SwiftUI
import Router
import Networking

enum SearcnDesination: Identifiable {
    var id: String {
        switch self {
        case .search:
            return "search"
        }
    }

    case search
}

public struct LedgerCoordinator: View {
    enum Tab {
        case search
        case ledger
    }

    @EnvironmentObject private var router: Router
    @State private var ledger = Ledger(
        service: LedgerService(
            networking: NetworkService(host: "localhost")
        )
    )

    @State private var selection: Tab = .search

    public init() { }

    public var body: some View {
        TabView(selection: $selection) {
            NavigationStack {
                RegistryList()
                    .environment(ledger)
            }
            .tabItem {
                let menuText = Text("Ledger", comment: "Your ledger list")
                Label {
                    menuText
                } icon: {
                    Image(systemName: "list.bullet")
                }.accessibility(label: menuText)
            }
            .tag(Tab.ledger)

            NavigationStack {
                SearchView()
                    .environment(ledger)
            }
            .tabItem {
                Label {
                    Text("Search",
                         comment: "Search stocks by symbol")
                } icon: {
                    Image(systemName: "magnifyingglass")
                }
            }
            .tag(Tab.search)
        }
        .modelContainer(for: Registry.self)
    }
}

#Preview {
    return LedgerCoordinator()
}
