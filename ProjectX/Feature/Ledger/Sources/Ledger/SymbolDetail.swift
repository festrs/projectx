//
//  SymbolDetail.swift
//
//
//  Created by Felipe Dias Pereira on 04/07/24.
//

import SwiftUI

struct SymbolDetail: View {
    @State var viewModel: SymbolDetailViewModel

    init(viewModel: SymbolDetailViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        if viewModel.isLoading {
            Text("Is loading...")
                .task {
                    await viewModel.search()
                }
        } else {
            if let quote = viewModel.quote {
                Text(quote.symbol)
            } else {
                Text("Not found")

            }
        }
    }
}

//#Preview {
//    SymbolDetail(symbol: "HGLG")
//}
