//
//  ViewMedicationsView.swift
//  Medario
//
//  Created by Lilly on 2021-11-02.
//

import SwiftUI

struct ViewMedicationsView: View {
    
    // make an array of user models
    @State var userModels: [UserModel] = []

    var body: some View {
        
        // create navigation view
        NavigationView {
            VStack{
                
                // create list view to show users
                List (self.userModels) { (model) in
                    
                    // show name, email, username and icon horizontally
                    
                    HStack{
                        Text(model.name)
                        Spacer()
                        Text(model.email)
                        Spacer()
                        Text(model.username)
                        Spacer()
                        Text(model.icon)
                        Spacer()
                        Text(model.medications)
                    }
                    
                }
                
                // create link to add medication
                HStack {
                    Spacer()
                    NavigationLink(destination: AddMedicationView(), label: { Text("Add Medication")
                        
                    })
                }
            }.padding()
            
            // load data in user models array
            // SEARCH
            .onAppear(perform : {
                self.userModels =
                    DB_Manager().getUsers()
            })
        }
    }
}

struct ViewMedicationsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewMedicationsView()
    }
}
