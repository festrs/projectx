//
//  ContentView.swift
//  ProjectX
//
//  Created by Felipe Dias Pereira on 28/05/24.
//

import SwiftUI
import Networking
import Router
import Ledger

struct ContentView: View {
    let service = NetworkService(host: "www.demo.com")
    @StateObject var router = Router()

    var body: some View {
        NavigationStack(path: $router.navPath) {
            LedgerCoordinator()
        }
        .environmentObject(router)
    }
}

#Preview {
    ContentView()
}
