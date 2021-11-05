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
                    Text("Medario").font(.system(size: 60)).padding(.bottom)
                    Image("MedarioLogo")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all).frame(width: 130, height: 130, alignment: .center).padding(15)
                        .padding(.bottom)
                    
                    //TODO: Change destination to SignUpView
                    NavigationLink(destination: SignInView()){
                        Text("Register")
                    }.buttonStyle(MenuButtonStyle()).frame( alignment: .topLeading)
                    
                    NavigationLink(destination: LoginView()){
                        Text("Login")
                    }.buttonStyle(MenuButtonStyle())
                        .padding(.top)
                
            }
        }

    }
}
    
//Custom Colors
struct CustomColor {
    static let lightPurple = Color("LightPurple")
    static let bluePurple = Color("BluePurple")
    
}

//Custom Button Style
struct MenuButtonStyle: ButtonStyle{
    //ButtonStyle has a standard method that needs to be defined for it which is caled makeBody
    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 129, height: 32, alignment: .center)
            .padding()
            .font(.headline)
            .background(RoundedRectangle(cornerRadius: 10).fill(CustomColor.lightPurple))
//            .border(CustomColor.bluePurple, width: 5)
            .buttonStyle(.bordered)
    }
}

}
