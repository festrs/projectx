//
//  LedgerHome.swift
//
//
//  Created by Felipe Dias Pereira on 21/06/24.
//

import SwiftUI
import Router
import Networking

struct LedgerHome: View {
    @Environment(\.modelContext) var modelContext
    @EnvironmentObject var router: Router
    @State var viewModel: LedgerHomeViewModel

    var body: some View {
        List {
            ForEach(viewModel.filteredSymbols) { name in
                NavigationLink {
                    SymbolDetail(
                        viewModel: SymbolDetailViewModel(
                            symbol: name.symbol,
                            service: viewModel.service
                        )
                    )
                } label: {
                    Text(name.symbol)
                }
            }
        }
        .onAppear {
            viewModel.loadSymbols()
        }
        .onChange(of: viewModel.searchText, { oldValue, newValue in
            viewModel.search(keyword: newValue)
        })
        .searchable(text: $viewModel.searchText)
    }

    func addRegistry() {
        let registry = Registry(createdDate: Date(), name: "", code: "", price: 0.0, isSell: false)
        modelContext.insert(registry)
        router.navigate(to: registry)
    }
}

#Preview {
    @StateObject var router = Router()
    do {
        let previewer = try Previewer()
        let networking = NetworkService(host: "https://www.alphavantage.co")
        let service = LedgerService(networking: networking)
        return NavigationStack(path: $router.navPath) {
            LedgerHome(viewModel: LedgerHomeViewModel(service: service) )
        }
        .modelContainer(previewer.container)
        .environmentObject(router)
    } catch {
        return Text("Error")
    }
}
