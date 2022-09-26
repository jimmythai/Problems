//
//  ContentView.swift
//  Problems
//
//  Created by Atsushi Yamamoto on 2022/09/09.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Button Problems", destination: ButtonProblemView())
                NavigationLink("Border Problems", destination: BorderProblemView())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
