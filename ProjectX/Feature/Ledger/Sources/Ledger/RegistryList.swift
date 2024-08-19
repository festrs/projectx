//
//  RegistryList.swift
//
//
//  Created by Felipe Dias Pereira on 20/06/24.
//

import SwiftUI
import SwiftData
import Router

struct RegistryList: View {
    @Environment(\.modelContext) var modelContext
    @Environment(Ledger.self) var ledger
    @Query var book: [Registry]
    @State private var showingEdit = false

    var body: some View {
        let _ = Self._printChanges()
        List {
            ForEach(book) { registry in
                NavigationLink {
                    //                        QuoteDetailView(symbol: registry.code)
                    //                            .environment(ledger)
                    Text(registry.code)
                } label: {
                    Text(registry.name)
                }

                //                    NavigationLink(value: registry) {
                //                        Text(registry.name)
                //                    }
            }
            .onDelete(perform: deleteRegistry)
        }
        .sheet(isPresented: $showingEdit) {
            EditRegistry(registry: Registry(name: "", code: "", price: 0, isSell: false))
            //.presentationDetents([.fraction(0.5), .large])
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button(action: {
                    showingEdit.toggle()
                    //router.navigateToRoot()
                    //                    router.navPath = NavigationPath()
                    //                    router.presentedSheet = nil
                }) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    func deleteRegistry(at offsets: IndexSet) {
        for offset in offsets {
            let registry = book[offset]
            modelContext.delete(registry)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return RegistryList()
            .modelContainer(previewer.container)
            .environmentObject(Router())
    } catch {
        return Text("Error")
    }
}
