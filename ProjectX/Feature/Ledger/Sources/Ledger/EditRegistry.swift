//
//  EditRegistry.swift
//
//
//  Created by Felipe Dias Pereira on 20/06/24.
//

import SwiftUI
import Router

struct EditRegistry: View {
    @State var registry: Registry
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        let _ = Self._printChanges()
        NavigationStack {
            Form {
                Section {
                    Text(registry.name)
                    Text(registry.code)                    
                    TextField("Valor", value: $registry.price, format: .currency(code: "BRL"))
                        .keyboardType(.numberPad)
                    Toggle("isSell", isOn: $registry.isSell)
                    DatePicker(selection: $registry.createdDate, in: ...Date(), displayedComponents: .date) {
                        Text("Date")
                    }
                }
            }
            .navigationTitle("Edit Registry")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button(action: save) {
                    Text("Save")
                    }
                }
            }
        }
    }

    func save() {
        modelContext.insert(registry)
        dismiss()
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        return EditRegistry(
            registry: previewer.registry
        )
        .modelContainer(previewer.container)
    } catch {
        return Text("Error")
    }
}
