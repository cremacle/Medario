//
//  DB_Manager.swift
//  Medario
//
//  Created by Giovanna Coral on 2021-11-04.
//

import Foundation
import SQLite

class DB_Manager {
    
    // 1. create connection with db
    public var db: Connection!
    
    // 2. create table instance
    public var users: Table!
    
    // 3. create column instances
    private var id: Expression<Int64>!
    private var name: Expression<String>!
    private var email: Expression<String>!
    private var username: Expression<String>!
    private var icon: Expression<String>!
    private var medications: Expression<String>!
    
    init () {
        
        do {
            
            // path of document directory
            let path: String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
            
            // creating database connection
            db = try Connection("\(path)/my_users.sqlite3")
            
            // create table obj
            users = Table("users")
            
            // create instances for each column
            id = Expression<Int64>("id")
            name = Expression<String>("name")
            email = Expression<String>("email")
            username = Expression<String>("username")
            icon = Expression<String>("icon")
            medications = Expression<String>("medications")
            
            // check if the user's table is already created
            if (!UserDefaults.standard.bool(forKey: "is_db_created")){
                
                // if not create table
                try db.run(users.create { (t) in
                    t.column(id, primaryKey: true)
                    t.column(name)
                    t.column(email, unique: true)
                    t.column(username, unique: true)
                    t.column(icon)
                    t.column(medications) // EDIT
                })
                
                // set the value to true so it won't try to create the table again
                UserDefaults.standard.set(true, forKey: "is_db_created")
            }
        } catch {
            // show error message if any
            print(error.localizedDescription)
        }
    }
    
    // EDIT: JSON object for medication list
    public func addUser(nameValue: String, emailValue: String, usernameValue: String, iconValue: String, medicationList: String){
        
        do {
            try db.run(users.insert(name <- nameValue, email <- emailValue, username <- usernameValue, icon <- iconValue, medications <- medicationList))
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // return array of MEDICATIONS (NOT user models)
    public func getMedications(){
        // TODO: display the medications
    }
    
    // test - get all users
    public func getUsers() -> [UserModel]{
        
        var userModels: [UserModel] = []
        
        users = users.order(id.desc)
        
        // exception handling
        do {
            
            // loop through all users
            for user in try db.prepare(users){
                
                // create a new model in each loop iteration
                let userModel: UserModel = UserModel()
                
                // set values in model from database
                userModel.id = user[id]
                userModel.name = user[name]
                userModel.email = user[email]
                userModel.username = user[username]
                userModel.icon = user[icon]
                userModel.medications = user[medications]
                
                // append in new array
                userModels.append(userModel)
            }
        }catch {
            print(error.localizedDescription)
        }
        
        // return array
        return userModels
    }
}
