//
//  ContentView.swift
//  CircleCIDemo
//
//  Created by Tadashi Nemoto on 2021/11/20.
//

import SwiftUI

struct ContentView: View {
    @State var text = "Hello, world!"
    
    var body: some View {
        Text(text)
            .padding()
            .accessibility(identifier: "text")
        Button(action: {
            text = "Button Tapped!"
        }){
            Text("Tap this button")
                .accessibility(identifier: "button")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
