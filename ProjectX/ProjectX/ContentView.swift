//
//  ContentView.swift
//  ProjectX
//
//  Created by Felipe Dias Pereira on 28/05/24.
//

import SwiftUI
import Networking
import Router

struct ContentView: View {
    let service = NetworkService(host: "www.demo.com")
    @ObservedObject var router = Router()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .sheet(item: $router.presentedSheet) { destination in
            
        }
    }
}

#Preview {
    ContentView()
}
