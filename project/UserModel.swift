//
//  UserModel.swift
//  project
//
//  Created by Kachan Oleksii on 12/7/18.
//  Copyright © 2018 De La Rosa Rivero Francisco. All rights reserved.
//

import Foundation

class UserModel {
    var firstName : String
    var lastName : String
    var login : String
    var email : String
    
    init(firstName: String, lastName: String, login: String, email: String){
        
        self.firstName = firstName
        self.lastName = lastName
        self.login = login
        self.email = email
    }
    
    func getFullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    func getInitials() -> String {
        return "\(self.firstName.uppercased().prefix(1)) \(self.lastName.uppercased().prefix(1))"
    }
}
