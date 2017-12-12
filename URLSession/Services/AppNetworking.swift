//
//  AppNetworking.swift
//  StarterProj
//
//  Created by Gurdeep on 16/12/16.
//  Copyright © 2016 Gurdeep. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias HTTPHeaders = [String : String]
typealias JSONDictionary = [String : Any]
typealias JSONDictionaryArray = [JSONDictionary]
typealias SuccessResponse = (_ json : JSON) -> ()
typealias FailureResponse = (Error) -> (Void)
//typealias UserControllerSuccess = (_ user : User) -> ()

extension Notification.Name {
    
    static let NotConnectedToInternet = Notification.Name("NotConnectedToInternet")
}

enum AppNetworking {
    
//    static let USER = "admin"
//    static let PASSWORD = "mypass"
//    static let REALM = "8AC74BD0018D507238924D65D0184E93"
//    static let NONCE = "12345"
//    static let QOP = "auth"
//    static let NONCE_COUNT = "12345"
//    static let CNONCE = "123"

    static let username = "admin"
    static let password = "12345"
    
    static func POST(endPoint : WebServices.EndPoint,
                     parameters : JSONDictionary = [:],
                     headers : HTTPHeaders = [:],
                     contentType: ContentType = .json,
                     loader : Bool = true,
                     success : @escaping (JSON) -> Void,
                     failure : @escaping (Error) -> Void) {
        
        Networking.shared.request(URLString: endPoint.path, httpMethod: .post, parameters: parameters, contentType: contentType, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func POSTWithImage(endPoint : WebServices.EndPoint,
                              parameters : [String : Any] = [:],
                              image : [String:UIImage]? = [:],
                              headers : HTTPHeaders = [:],
                              contentType: ContentType = .multiPart,
                              loader : Bool = true,
                              success : @escaping (JSON) -> Void,
                              failure : @escaping (Error) -> Void) {
        
        Networking.shared.upload(URLString: endPoint.path, httpMethod: .post, parameters: parameters,image: image ,headers: headers, contentType: contentType, loader: loader, success: success, failure: failure )
    }
    
    static func GET(endPoint : WebServices.EndPoint,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    contentType: ContentType = .json,
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        Networking.shared.request(URLString: endPoint.path, httpMethod: .get, parameters: parameters, contentType: contentType, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func PUT(endPoint : WebServices.EndPoint,
                    parameters : JSONDictionary = [:],
                    headers : HTTPHeaders = [:],
                    contentType: ContentType = .json,
                    loader : Bool = true,
                    success : @escaping (JSON) -> Void,
                    failure : @escaping (Error) -> Void) {
        
        Networking.shared.request(URLString: endPoint.path, httpMethod: .put, parameters: parameters, contentType: contentType, headers: headers, loader: loader, success: success, failure: failure)
    }
    
    static func DELETE(endPoint : WebServices.EndPoint,
                       parameters : JSONDictionary = [:],
                       headers : HTTPHeaders = [:],
                       contentType: ContentType = .json,
                       loader : Bool = true,
                       success : @escaping (JSON) -> Void,
                       failure : @escaping (Error) -> Void) {
        
        Networking.shared.request(URLString: endPoint.path, httpMethod: .delete, parameters: parameters, contentType: contentType, headers: headers, loader: loader, success: success, failure: failure)
    }
}




