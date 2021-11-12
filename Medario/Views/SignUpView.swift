//
//  SignUpView.swift
//  Medario
//
//  Created by Giovanna Coral on 2021-11-04.
//

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var username: String = ""
    @State var icon: String = ""
    @State var medications: String = ""
    @State var pfpSelection = 0
    let pfpOptions = ["chocolatee", "teacup"]
    // EDIT - add empty JSON object that will hold medications
    
    // ^ this info is UPDATABLE too

    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            Text("Sign Up")
            Section{
                HStack{
                    Image(pfpOptions[pfpSelection]).resizable()
                        .frame(width: 100, height: 100).clipShape(Circle()).overlay(Circle().stroke(Color.white, lineWidth: 2))
                    Text("Icon chosen: ")
                    Picker(selection: $pfpSelection, label: Text("Change Photo")) {
                        Section(header: Text("Change Photo")){
                        ForEach(0 ..< pfpOptions.count) { (i) in
                            HStack {
                                Text(self.pfpOptions[i])
                            }.tag(i)
                        }
                    }}.pickerStyle(MenuPickerStyle())}
            
            TextField("Enter name", text: $name)
                .padding(10)
                .background(Color(.systemPink))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter email", text: $email)
                .padding(10)
                .background(Color(.systemPink))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter username", text: $username)
                .padding(10)
                .background(Color(.systemPink))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Select your icon", text: $icon)
                .padding(10)
                .background(Color(.systemPink))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            Button(action: {
                // call function to add row in sqilte database
                DB_Manager().addUser(nameValue: self.name, emailValue: self.email, usernameValue: self.username, iconValue: self.icon, medicationList: self.medications)
                                
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Sign Up")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
    }
}

}
