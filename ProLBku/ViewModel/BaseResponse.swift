//
//  BaseResponse.swift
//  ProLBku
//
//  Created by mac on 09/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse: Mappable {
    
    var code : String?
    var message: String?
    var lautan_berlian: String?
    var access_token: String?
    required init?(map: Map){
        
    }
    
    func mapping(map: Map) {
        lautan_berlian <- map["lautan_berlian.code"]
        code <- map["code"]
        message <- map["lautan_berlian.message"]
        access_token <- map["lautan_berlian.result.access_token"]
    }
    
}

