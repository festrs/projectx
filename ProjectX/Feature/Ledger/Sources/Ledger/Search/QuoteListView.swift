//
//  SwiftUIView.swift
//
//
//  Created by Felipe Dias Pereira on 10/07/24.
//

import SwiftUI
import Router

struct QuoteListView: View {
    @Environment(Ledger.self) private var ledger
    var quotes: [SearchResult.Quote]    

    var body: some View {
        let _ = Self._printChanges()
        ForEach(quotes) { quote in
            NavigationLink {
                QuoteDetailView(symbol: quote.symbol)
                    .environment(ledger)
            } label: {
                HStack {
                    VStack(alignment: .leading) {
                        Text(quote.symbol)
                            .fontWeight(.regular)
                        Text(quote.shortname)
                            .font(.footnote)
                            .fontWeight(.light)
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        List {
            QuoteListView(quotes: [.apple, .bbse])
        }
    }
}
