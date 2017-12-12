//
//  Networking.swift
//  URLSession
//
//  Created by Bhavneet Singh on 12/12/17.
//  Copyright © 2017 Bhavneet Singh. All rights reserved.
//

import Foundation
import SwiftyJSON

class Networking {
    
    private init(){}
    static let shared = Networking()
    
    fileprivate let session = URLSession.shared
    
    
    func request(URLString : String,
                 httpMethod : HTTPMethod,
                 parameters : JSONDictionary = [:],
                 contentType: ContentType,
                 headers : HTTPHeaders = [:],
                 loader : Bool = true,
                 success : @escaping (JSON) -> Void,
                 failure : @escaping (Error) -> Void) {
        
        self.serviceRequest(URLString : URLString,
                  httpMethod : httpMethod,
                  parameters : parameters,
                  headers : headers,
                  contentType: contentType,
                  loader : loader,
                  success: { (json) in
            
                    success(json)
                    
        }) { (error) in
            
            failure(error)
            
        }
    }
    
    
    func upload(URLString : String,
                httpMethod : HTTPMethod,
                parameters : JSONDictionary = [:],
                image : [String:UIImage]? = [:],
                headers : HTTPHeaders = [:],
                contentType: ContentType,
                loader : Bool = true,
                success : @escaping (JSON) -> Void,
                failure : @escaping (Error) -> Void) {
        
        
        
    }
    
    
    func download(URLString : String,
                  httpMethod : HTTPMethod,
                  parameters : JSONDictionary = [:],
                  image : [String:UIImage]? = [:],
                  headers : HTTPHeaders = [:],
                  loader : Bool = true,
                  success : @escaping (JSON) -> Void,
                  failure : @escaping (Error) -> Void) {
        
        
    }
    
    fileprivate func put(success : @escaping (JSON) -> Void,
                         failure : @escaping (Error) -> Void) {
        
        
        
    }
    
    fileprivate func get(success : @escaping (JSON) -> Void,
                         failure : @escaping (Error) -> Void) {
        
        
        
    }
    
    fileprivate func delete(success : @escaping (JSON) -> Void,
                            failure : @escaping (Error) -> Void) {
        
        
        
    }
    
    fileprivate func serviceRequest(URLString : String,
                          httpMethod : HTTPMethod,
                          parameters : JSONDictionary = [:],
                          headers : HTTPHeaders = [:],
                          contentType: ContentType,
                          loader : Bool = true,
                          success : @escaping (JSON) -> Void,
                          failure : @escaping (Error) -> Void) {
        
        guard let url = URL(string: URLString) else {
            failure(NSError(localizedDescription: "Incorrect URL"))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        if contentType == .urlEncoded {
            request.httpBody = getHttpBody(parameters)
        } else if contentType == .json {
            
            guard let body = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                failure(NSError(localizedDescription: "Incorrect Parameters"))
                return
            }
            
            request.httpBody = body
        }
        
        request.addValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
        
        session.dataTask(with: request) { (data, response, error) in
            
            do {
                guard let d = data else {
                    failure(NSError(localizedDescription: "Incorrect Response"))
                    return
                }
                let dict = try JSONSerialization.jsonObject(with: d, options: [])
                success(JSON(dict))
            } catch {
                failure(error)
            }
            
        }.resume()
    }
    
}
