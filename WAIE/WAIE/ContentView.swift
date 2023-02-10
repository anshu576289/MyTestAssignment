//
//  ContentView.swift
//  WAIE
//
//  Created by Anshu Kumar Ray on 09/02/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = AstronomyViewModel()
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
