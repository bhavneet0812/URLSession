//
//  Webservices.swift
//  StarterProj
//
//  Created by Gurdeep on 16/12/16.
//  Copyright © 2016 Gurdeep. All rights reserved.
//

import Foundation
import SwiftyJSON

enum WebServices { }

extension NSError {

    convenience init(localizedDescription : String) {
        
        self.init(domain: "AppNetworkingError", code: 0, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
    
    convenience init(code : Int, localizedDescription : String) {
        
        self.init(domain: "AppNetworkingError", code: code, userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
}

extension WebServices {

    static func putPost(parameter: JSONDictionary,
                           success: @escaping (JSON) -> Void,
                           failure: @escaping (Error) -> Void) {
        
        AppNetworking.PUT(endPoint: .putOrDeletePosts, parameters: parameter, headers: HTTPHeaders(), loader: false, success: { (json) in
            
            print(parameter)
            success(json)
        }) { (error) in
            
            print(error.localizedDescription)
            failure(error)
            
        }
    }

    static func getPosts(parameter: JSONDictionary,
                         success: @escaping (JSON) -> Void,
                         failure: @escaping (Error) -> Void) {
        
        AppNetworking.GET(endPoint: .posts, parameters: parameter, headers: HTTPHeaders(), loader: false, success: { (json) in
            
            print(parameter)
            success(json)
        }) { (error) in
            
            print(error.localizedDescription)
            failure(error)
        }
    }

    static func deletePost(parameter: JSONDictionary,
                           success: @escaping (JSON) -> Void,
                           failure: @escaping (Error) -> Void) {
        
        AppNetworking.DELETE(endPoint: .putOrDeletePosts, parameters: parameter, headers: HTTPHeaders(), loader: false, success: { (json) in
            
            print(parameter)
            success(json)
        }) { (error) in
            
            print(error.localizedDescription)
            failure(error)

        }
    }

    static func postPosts(parameter: JSONDictionary,
                          success: @escaping (JSON) -> Void,
                          failure: @escaping (Error) -> Void) {
        
        AppNetworking.POST(endPoint: .posts, parameters: parameter, headers: HTTPHeaders(), loader: false, success: { (json) in
            
            print(parameter)
            success(json)
        }) { (error) in
            
            print(error.localizedDescription)
            failure(error)
            
        }
    }

}

//MARK:- Error Codes
//==================
struct error_codes {
    static let success = 200
    
}

