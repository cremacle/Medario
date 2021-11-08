//
//  AddMedicationView.swift
//  Medario
//
//  Created by Giovanna Coral on 2021-11-04.
//

import SwiftUI

struct AddMedicationView: View {
    
    // add a medication
    // name, dosage, amount, and date/time
    @State var name: String = ""
    @State var dosage: String = ""
    @State var amount: String = "" // EDIT: float
    @State var dateTime: String = "" // EDIT
    
    
    // ^ this info is UPDATABLE too
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {

        VStack{
            TextField("Enter name", text: $name)
                .padding(10)
                .background(Color(.systemPink))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter dosage", text: $dosage)
                .padding(10)
                .background(Color(.systemPink))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter amount", text: $amount)
                .padding(10)
                .background(Color(.systemPink))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            TextField("Enter the date and time you take this medication", text: $dateTime)
                .padding(10)
                .background(Color(.systemPink))
                .cornerRadius(5)
                .disableAutocorrection(true)
            
            Button(action: {
                // call function to add row in sqilte database
                
                // go back to home page
                
                self.mode.wrappedValue.dismiss()
            }, label: {
                Text("Add Medication")
            })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.top, 10)
                .padding(.bottom, 10)
        }.padding()
    }
}

struct AddMedicationView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedicationView()
    }
}
