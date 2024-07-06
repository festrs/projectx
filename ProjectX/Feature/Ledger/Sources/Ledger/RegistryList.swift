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
    @Query var book: [Registry]

    var body: some View {
        List {
            ForEach(book) { registry in
                NavigationLink(value: registry) {
                    Text(registry.name)
                }
            }
            .onDelete(perform: deleteRegistry)
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
