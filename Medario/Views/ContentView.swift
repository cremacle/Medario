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
               
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    Text("Medario").font(.title)
                    Image("MedarioLogo")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all).frame(width: 130, height: 130, alignment: .center)
                    
//                    NavigationLink(destination: SignInView()){
//                        Text("Register")
//                    }.buttonStyle(MenuButtonStyle()).frame( alignment: .topLeading)
                    
                    NavigationLink(destination: LoginView()){
                        Text("Login")
                    }.buttonStyle(MenuButtonStyle()).frame( alignment: .topLeading)
                }
                
            }
            
        }

    }
}

struct MenuButtonStyle: ButtonStyle{
    //ButtonStyle has a standard method that needs to be defined for it which is caled makeBody
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
