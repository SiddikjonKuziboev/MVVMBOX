//
//  API.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 10/23/22.
//

import Foundation
import SwiftyJSON
import Alamofire

struct EndPoints {
    static let baseUrl = "https://dummyapi.io/data/v1"
    static let getUser = baseUrl + "/user?limit=10"
}

class API {
    
    static let shared: API = .init()
    
    func getUser(completion: @escaping ([UserDM]?)-> Void) {
        
        Network.shared.request(url: EndPoints.getUser, method: .get) { data in
            guard let data = data else{return completion([])}
            let users: [UserDM] = data["data"].arrayValue.map { j in
                return UserDM.init(json: j)
            }
            completion(users)
        }
        
        
    }
    
}
