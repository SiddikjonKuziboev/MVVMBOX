//
//  UserVM.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 10/23/22.
//

import Foundation

class UserVM {
    
    var users: Box<[UserDM]> = Box([])
    
    func getAllUser() {
        API.shared.getUser { users in
            self.users.value = users ?? []
        }
    }
}
