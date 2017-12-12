//
//  ParameterEncoding.swift
//  URLSession
//
//  Created by Bhavneet Singh on 12/12/17.
//  Copyright © 2017 Bhavneet Singh. All rights reserved.
//

import Foundation

public enum ContentType: String {
    case json     = "application/json"
    case urlEncoded = "application/x-www-form-urlencoded"
    case multiPart     = "multipart/form-data"
}

public enum HTTPMethod: String {
    case get     = "GET"
    case put     = "PUT"
    case delete  = "DELETE"
    case post    = "POST"
}

public enum URLEncoding {
    case queryString
    case httpBody
}


func getHttpBody(_ parameters: [String: Any]) -> Data? {
    return query(parameters).data(using: .utf8)
}


func query(_ parameters: [String: Any]) -> String {
    var components: [(String, String)] = []
    
    for key in parameters.keys.sorted(by: <) {
        let value = parameters[key]!
        components += queryComponents(fromKey: key, value: value)
    }
    return components.map { "\($0)=\($1)" }.joined(separator: "&")
}

private func encodesParametersInURL(with method: HTTPMethod) -> Bool {
    
    switch method {
    case .get, .delete:
        return true
    default:
        return false
    }
}

public func queryComponents(fromKey key: String, value: Any) -> [(String, String)] {
    var components: [(String, String)] = []
    
    if let dictionary = value as? [String: Any] {
        for (nestedKey, value) in dictionary {
            components += queryComponents(fromKey: "\(key)[\(nestedKey)]", value: value)
        }
    } else if let array = value as? [Any] {
        for value in array {
            components += queryComponents(fromKey: "\(key)[]", value: value)
        }
    } else if let value = value as? NSNumber {
        if value.isBool {
            components.append((escape(key), escape((value.boolValue ? "1" : "0"))))
        } else {
            components.append((escape(key), escape("\(value)")))
        }
    } else if let bool = value as? Bool {
        components.append((escape(key), escape((bool ? "1" : "0"))))
    } else {
        components.append((escape(key), escape("\(value)")))
    }
    
    return components
}

public func escape(_ string: String) -> String {
    let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
    let subDelimitersToEncode = "!$&'()*+,;="
    
    var allowedCharacterSet = CharacterSet.urlQueryAllowed
    allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
    
    var escaped = ""
    
    let batchSize = 50
    var index = string.startIndex
    
    while index != string.endIndex {
        let startIndex = index
        let endIndex = string.index(index, offsetBy: batchSize, limitedBy: string.endIndex) ?? string.endIndex
        let range = startIndex..<endIndex
        
        let substring = string[range]
        
        escaped += substring.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? String(substring)
        
        index = endIndex
    }
    
    return escaped
}


extension NSNumber {
    fileprivate var isBool: Bool { return CFBooleanGetTypeID() == CFGetTypeID(self) }
}
