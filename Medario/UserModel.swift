//
//  UserModel.swift
//  Medario
//
//  Created by Giovanna Coral on 2021-11-04.
//

import Foundation

class UserModel : Identifiable {
    public var id: Int64 = 0
    public var name: String = ""
    public var email: String = ""
    public var username: String = ""
    public var icon: String = ""
    public var medications: String = "" //EDIT
}
