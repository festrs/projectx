//
//  ContentView.swift
//  ProjectX
//
//  Created by Felipe Dias Pereira on 28/05/24.
//

import SwiftUI
import Networking

struct ContentView: View {
    let service = NetworkService(host: "www.demo.com")
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
