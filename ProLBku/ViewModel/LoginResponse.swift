//
//  LoginResponse.swift
//  ProLBku
//
//  Created by mac on 09/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginResponse: Mappable {

    var user_id: Int?
    var access_token: String?
    var roles: String?
    
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        user_id <- map["result.user_id"]
        access_token <- map["result.access_token"]
        roles <- map["result.roles"]
    }
}
