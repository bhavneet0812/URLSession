//
//  Webservice+EndPoints.swift
//  StarterProj
//
//  Created by Gurdeep on 06/03/17.
//  Copyright © 2017 Gurdeep. All rights reserved.
//

import Foundation

let BASE_URL = "https://jsonplaceholder.typicode.com"

extension WebServices {

    enum EndPoint : String {
        case posts = "/posts"
        case putOrDeletePosts = "/posts/1"

        var path : String {
            let url = BASE_URL
            return url + self.rawValue
        }
    }
}
