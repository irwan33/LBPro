//
//  AuthEngine.swift
//  ProLBku
//
//  Created by mac on 09/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit
import ObjectMapper


class UserEngine: Engine {

    class func login(_ email:String, password:String, completionHandler:RequestCompletionHandler?){
        let url = "\(Endpoints.BASE)\(Endpoints.LOGIN)"
        let params = ["email": email,
                      "password": password]
        self.postRequest(url: url, parameters: params) { (result, error) in
            if error != nil{
                completionHandler!(result, error)
                return
            }
            let baseResponse = Mapper<BaseResponse>().map(JSONObject: result)
            if !(baseResponse!.code != nil){
                completionHandler!(baseResponse, error)
                return
            }
            let response = Mapper<LoginResponse>().map(JSONObject: result)
            if response?.access_token != nil{
//                UserDefaults.standard.set(true, forKey: UserDefaultConstant.IS_LOGIN)
             
                UserDefaults.standard.set(response?.access_token, forKey: UserDefaultConstant.ACCESS_TOKEN)
                completionHandler!(response, error)
            }else{
                completionHandler!(result, error)
            }
        }
    }
    
    
    class func forgotPassword(_ email:String, completionHandler:RequestCompletionHandler?){
        let url = "\(Endpoints.BASE)\(Endpoints.FORGOT_PASSWORD)"
        let params = ["email": email]
        self.postRequest(url: url, parameters: params) { (result, error) in
            if error != nil{
                completionHandler!(result, error)
                return
            }
            let baseResponse = Mapper<BaseResponse>().map(JSONObject: result)
            completionHandler!(baseResponse, error)
            completionHandler!(result, error)
        }
    }
    
    class func signupUser(_ email:String, first_name:String, last_name:String, gender:String, pass1:String, pass2:String, phone:String, address:String, city:String, province:String, postal_code:String, completionHandler:RequestCompletionHandler?){
        let url = "\(Endpoints.BASE)\(Endpoints.SIGNUP_SUBMIT)"
        let params = ["email": email,
                      "first_name": first_name,
                      "last_name": last_name,
                      "gender": gender,
                      "pass1": pass1,
                      "pass2": pass2,
                      "phone": phone,
                      "address": address,
                      "city": city,
                      "province": province,
                      "postal_code": postal_code]
        self.postRequest(url: url, parameters: params) { (result, error) in
            if error != nil{
                completionHandler!(result, error)
                return
            }
            let baseResponse = Mapper<BaseResponse>().map(JSONObject: result)
            completionHandler!(baseResponse, error)
            completionHandler!(result, error)
        }
    }
}
