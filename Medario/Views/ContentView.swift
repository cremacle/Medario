//
//  ContentView.swift
//  Medario
//
//  Created by Chris Remacle on 2021-11-02.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView{
            ZStack{
                VStack{
                    HStack{
                        NavigationLink(destination: SignUpView(), label: { Text("Add user") })
                        
                        NavigationLink(destination: ViewMedicationsView(), label: { Text("Add user") })
                    }
                }
            }
        }
        Text("Hello, world!")
            .padding()        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
