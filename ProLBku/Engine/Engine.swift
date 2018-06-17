//
//  Engine.swift
//  ProLBku
//
//  Created by mac on 09/05/18.
//  Copyright © 2018 irwan. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

typealias RequestCompletionHandler = (_ result: Any?, _ error: Error?) -> Void

class Engine{
    
    static var manager:SessionManager?
    
    class func postRequest(url:String, parameters: [String: Any]? = nil, isTokenFromLogin: Bool = true, completionHandler:RequestCompletionHandler?){
        
        print("URL : \(url)")
        print("Params: \(parameters)")
        
        if manager == nil{
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 15.0
            configuration.timeoutIntervalForResource = 15.0
            manager = Alamofire.SessionManager(configuration: configuration)
        }
        
        manager!.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: self.getHeader(isTokenFromLogin))
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
                if response.result.value == "nil" {
//                    Toast.showNegativeMessage(message: "Pleace Cek Your Internet Connection")
                }
            }
            .responseJSON { response in
                self.isSessionExpired(response.result.value, error: response.result.error, type: "POST", url: url,parameters: parameters , completionHandler: completionHandler)
                                if (response.result.value != nil){
                                    print("Response : \(response.result.value)")
                                    completionHandler!(response.result.value, response.result.error as NSError?)
                                }else{
                                    print("Error : \(response.result.error)")
                                    completionHandler!(response.result.value, response.result.error as NSError?)
                                }
        }
    }
    
    
    class func getRequest(url:String,parameters: [String: Any]? = nil, completionHandler:RequestCompletionHandler?){
        
        print("URL : \(url)")
        print("Params: \(parameters)")
        
        if manager == nil{
            
            let configuration = URLSessionConfiguration.default
            configuration.timeoutIntervalForRequest = 15.0
            configuration.timeoutIntervalForResource = 15.0
            manager = Alamofire.SessionManager(configuration: configuration)
        }
        
        let queue = DispatchQueue.global(qos: .utility)
        
        let serializer = DataRequest.jsonResponseSerializer(options: .allowFragments)
        
        print("URL : \(url)")
        print("Params: \(parameters)")
        
        manager!.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: self.getHeader(false))
            .responseString { response in
                print("Success: \(response.result.isSuccess)")
                print("Response String: \(response.result.value)")
            }
            .responseJSON { response in
            }
            .response(
                queue: queue,
                responseSerializer: serializer,
                completionHandler: { response in
                    self.isSessionExpired(response.result.value, error: response.result.error, type: "POST", url: url,parameters: parameters , completionHandler: completionHandler)
                                        if (response.result.value != nil){
                                            print("Response : \(response.result.value)")
                                            completionHandler!(response.result.value, response.result.error)
                                        }else{
                                            print("Error : \(response.result.error)")
                                            completionHandler!(response.result.value, response.result.error)
                                        }
            })
    }
    
    
    class func cancelAllRequest(){
        manager?.session.invalidateAndCancel()
        //        Alamofire.SessionManager.default.session.invalidateAndCancel()
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30.0
        configuration.timeoutIntervalForResource = 30.0
        manager = Alamofire.SessionManager(configuration: configuration)
        
    }
    
    
    class func getHeader(_ isTokenFromLogin: Bool = false) -> HTTPHeaders{
        var authToken = "$2y$10$PfTNC8feMX7v/SSVnaaME.8/qRpV7Y2nQGnJin71pIhaj2cmwsGa"
        var header: HTTPHeaders = [:]
        header["Accept"] =  "application/json"
        if isTokenFromLogin{
            if let token = UserDefaults.standard.string(forKey: UserDefaultConstant.ACCESS_TOKEN){
                authToken = token
            }
        }
        header["key"] =  authToken
        header["Content-Type"] =  "application/x-www-form-urlencoded"
        print("Header: \(header)")
        return header
    }
    
    class func isSessionExpired(_ result: Any?, error: Error?, type: String, url:String,parameters: [String: Any]? = nil, completionHandler:RequestCompletionHandler?){
        if result != nil{
            let baseResponse = Mapper<BaseResponse>().map(JSONObject: result)
            if baseResponse?.message != nil{
                if baseResponse!.message == "access forbidden, wrong token"{
//                    UserEngine.logout()
                    let appDelegate = UIApplication.shared.delegate as? AppDelegate
//                    appDelegate?.setRootToLoginViewController()
                    return
                }
            }
        }
        completionHandler!(result, error)
    }
}
