//
//  LoginView.swift
//  Medario
//
//  Created by Lilly on 2021-11-02.
//

import SwiftUI

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    var body: some View {
        ZStack{
            Image("bluebackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Login").font(.system(size: 30)).bold()
                Text("Please sign in to continue").font(.system(size: 18)).bold().padding(.bottom, 60).foregroundColor(.gray)
                
                
                TextField("Email", text: $email).frame(height: 25)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .cornerRadius(5)
                        .disableAutocorrection(true)
                
                SecureField("Password", text: $password).frame(height: 25)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 16)
                        .cornerRadius(5)
                        .disableAutocorrection(true)
                
                
                Button(action: {}){Text("Login")}
                    .frame(width: 129, height: 54, alignment: .center)
                    .font(.headline)
                    .background(RoundedRectangle(cornerRadius:10)
                    .fill(CustomColor.lightPurple)).foregroundColor(Color.black).padding().padding(.top, 60)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
