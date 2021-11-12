//
//  SignUpView.swift
//  Medario
//
//  Created by Giovanna Coral on 2021-11-04.
//

import SwiftUI

//Custom Colors
struct CustomColor {
    static let lightPurple = Color("LightPurple")
}

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var username: String = ""
//    @State var icon: String = ""
    @State var medications: String = ""
    @State var pfpSelection = 0
    let pfpOptions = ["chocolatee", "teacup"]
    @State var password : String = ""
    @State var confirmPassword = ""
    // EDIT - add empty JSON object that will hold medications
    
    // ^ this info is UPDATABLE too

    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack{
            Image("bluebackground")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
        VStack{
            Text("Sign Up").font(.system(size: 30)).bold().padding(.bottom, 60)
            Section{
                HStack{
                    Image(pfpOptions[pfpSelection]).resizable()
                        .frame(width: 75, height: 75).clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Text("Icon chosen: ")
                    Picker(selection: $pfpSelection, label: Text("Change Photo")) {
                        Section(header: Text("Change Photo")){
                        ForEach(0 ..< pfpOptions.count) { (i) in
                            HStack {
                                Text(self.pfpOptions[i])
                            }.tag(i)
                        }
                        }}.pickerStyle(MenuPickerStyle())}
                //TODO: Save image to to database. What to save? pfpOptions[pfpSelection]
                
            
            TextField("First name", text: $name).frame(height: 25)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .cornerRadius(5)
                    .disableAutocorrection(true)
            
            TextField("Enter email", text: $email).frame(height: 25)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .cornerRadius(5)
                    .disableAutocorrection(true)
            
            TextField("Enter username", text: $username).frame(height: 25)
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
                
            SecureField("Confirm Password", text: $confirmPassword).frame(height:25)
                    .textFieldStyle(.roundedBorder)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 16)
                    .cornerRadius(5)
                    .disableAutocorrection(true)
            
    
            
            Button(action: {// call function to add row in sqilte database
                DB_Manager().addUser(nameValue: self.name, emailValue: self.email, usernameValue: self.username, iconValue: pfpOptions[pfpSelection], medicationList: self.medications)}){Text("Sign Up")}.frame(width: 129, height: 54, alignment: .center)
                .font(.headline)
                .background(RoundedRectangle(cornerRadius: 10).fill(CustomColor.lightPurple)).foregroundColor(Color.black).padding().padding(.top, 60)

    }
    }
}

}


}
