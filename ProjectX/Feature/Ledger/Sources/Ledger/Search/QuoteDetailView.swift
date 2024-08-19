//
//  SwiftUIView.swift
//
//
//  Created by Felipe Dias Pereira on 19/07/24.
//

import SwiftUI
import Router

struct QuoteDetailView: View {
    @Environment(Ledger.self) private var ledger
    private let symbol: String
    @State private var quote: Quote?
    @State private var showingCredits = false

    init(symbol: String) {
        self.symbol = symbol
    }

    var body: some View {
        List {
            if let quote = quote {
                VStack(alignment: .leading) {
                    Text(quote.symbol)
                    Text(quote.longName)
                }

                HStack {
                    Text(quote.regularMarketOpen.formatted(.currency(code: quote.currency)))
                    Text(quote.regularMarketChange.formatted(.number.grouping(.never).precision(.fractionLength(2))))
                        .foregroundStyle(quote.regularMarketChange > 0 ? .green : .red)
                }
                HStack {
                    Text(quote.fullExchangeName)
                    Spacer()
                    Text(quote.financialCurrency)
                }
                HStack {
                    Text("Symbol")
                    Spacer()
                    Text(quote.symbol)
                }

                HStack {
                    Text("Symbol")
                    Spacer()
                    Text(quote.longName)
                }

                HStack {
                    Text("Bid")
                    Spacer()
                    Text(quote.bid.formatted(.currency(code: quote.currency)))
                }

                HStack {
                    Text("Ask")
                    Spacer()
                    Text(quote.ask.formatted(.currency(code: quote.currency)))
                }

                HStack {
                    Text("Change")
                    Spacer()
                    Text(quote.regularMarketChange.formatted(.number.grouping(.never).precision(.fractionLength(2))))
                        .foregroundStyle(quote.regularMarketChange > 0 ? .green : .red)
                }

                ScrollView(.horizontal) {
                    LazyHStack {
                        VStack {
                            HStack {
                                Text("Open")
                                    .font(.footnote)
                                Spacer()
                                Text(quote.regularMarketOpen.formatted(.number.grouping(.never).precision(.fractionLength(2))))
                                    .font(.system(size: 12, weight: .semibold))
                            }
                            HStack {
                                Text("High")
                                    .font(.footnote)
                                Spacer()
                                Text(
                                    quote
                                        .regularMarketDayRange
                                        .high
                                        .formatted(
                                            .number.precision(.fractionLength(2))
                                        )
                                )
                                .font(.system(size: 12, weight: .semibold))
                            }
                            HStack {
                                Text("Low")
                                    .font(.footnote)
                                Spacer()
                                Text(
                                    quote
                                    .regularMarketDayRange
                                    .low
                                    .formatted(
                                        .number.precision(.fractionLength(2))
                                    )
                                )
                                    .font(.system(size: 12, weight: .semibold))
                            }
                        }
                        Divider()
                        Text("Second Row")
                        Divider()
                        Text("Third Row")
                        Divider()
                        Text("Third Row")
                        Divider()
                        Text("Third Row")
                        Divider()
                        Text("Third Row")
                    }
                }
                .sheet(isPresented: $showingCredits) {
                    EditRegistry(
                        registry: Registry(
                            name: quote.longName,
                            code: quote.symbol,
                            price: Decimal(quote.ask),
                            isSell: false
                        )
                    )
                    .presentationDetents([.fraction(0.5), .large])
                }
            } else {
                Text("Loading")
                    .onAppear {
                        Task {
                            quote = await ledger.fetchQuote(symbol: symbol)
                        }
                    }
            }
        }
        .listStyle(.inset)
        .refreshable {
            Task {
                quote = await ledger.fetchQuote(symbol: symbol)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    showingCredits.toggle()
                    //router.navigateToRoot()
                    //                    router.navPath = NavigationPath()
                    //                    router.presentedSheet = nil
                }) {
                    //Image(systemName: "plus")
                    Text("Add to ledger")

                }
            }
        }
        .navigationTitle("Detail")
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return NavigationStack {
            QuoteDetailView(symbol: "AAPL")
                .modelContainer(previewer.container)
                .environment(previewer.ledger)
        }
    } catch {
        return Text("Error")
    }
}
