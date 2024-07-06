//
//  EditRegistry.swift
//
//
//  Created by Felipe Dias Pereira on 20/06/24.
//

import SwiftUI

struct EditRegistry: View {
    @Bindable var registry: Registry

    var body: some View {
        Form {
            Section {
                TextField("Name", text: $registry.name)
                TextField("Code", text: $registry.code)
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
