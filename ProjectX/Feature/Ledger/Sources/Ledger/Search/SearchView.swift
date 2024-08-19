//
//  SwiftUIView.swift
//
//
//  Created by Felipe Dias Pereira on 19/07/24.
//

import SwiftUI

struct SearchView: View {
    @Environment(Ledger.self) private var ledger
    @StateObject var search: Search = Search()
    @State var isPresented: Bool = true
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        let _ = Self._printChanges()
        List {
            if let results = ledger.searchResult {
                QuoteListView(quotes: results.quotes)
            } else {
                Text("Something")
            }
        }
        .searchable(text: $search.text)
        .onChange(of: search.queryString) { _, newValue in
            Task {
                await ledger.search(query: newValue)
            }
        }
        .onChange(of: isPresented) {
            if !isPresented {
                //router.navigateToRoot()
                //router.presentedSheet = nil
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return SearchView()
            .modelContainer(previewer.container)
            .environment(previewer.ledger)
    } catch {
        return Text("Error")
    }
}
