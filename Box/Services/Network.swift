//
//  Network.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 10/20/22.
//

import Foundation
import Alamofire
import SwiftyJSON

class Network {
    
   static let shared: Network = .init()
    typealias NetworkResponse = ( (JSON?)-> Void)
    
    func request(url: String , method: HTTPMethod, param: Parameters? = nil, header: HTTPHeaders? = .appId(), completion: @escaping NetworkResponse) {
        AF.request( url , method: method, parameters: param, encoding: URLEncoding.default, headers: header ).responseJSON { response in
            if let data = response.data {
                completion(JSON(data))

            }else {
                completion(nil)

            }
        }
    }
    
}

extension HTTPHeaders {
    static func appId()-> HTTPHeaders {
        return ["app-id" : "63517e7a312a1a5d9b87a57e"]
    }
}
