//
//  UserDM.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 10/20/22.
//

import Foundation
import SwiftyJSON

struct UserDM: Decodable {
    var id: String
    var picture: String
    var firstName: String
    var lastName: String
    var title: String
   
    
    init(json: JSON) {
        self.picture = json["picture"].stringValue
        self.firstName = json["firstName"].stringValue
        self.lastName = json["lastName"].stringValue
        self.title = json["title"].stringValue
        self.id = json["id"].stringValue
    }
}
