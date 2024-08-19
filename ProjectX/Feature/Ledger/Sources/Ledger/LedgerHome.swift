//
//  LedgerHome.swift
//
//
//  Created by Felipe Dias Pereira on 21/06/24.
//

import SwiftUI
import SwiftData
import Router
import Networking

struct LedgerHome: View {
    @Environment(Ledger.self) private var ledger
    @EnvironmentObject private var router: Router

    init() { }

    var body: some View {
        let _ = Self._printChanges()
        VStack {
            Text("Inital")
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    router.presentSheet(destination: SearcnDesination.search)
                }) {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return NavigationStack() {
            LedgerHome()
        }
        .modelContainer(previewer.container)
        .environment(previewer.ledger)
    } catch {
        return Text("Error")
    }
}
