//
//  Resource.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

struct Resource {
    let url: URL
    let path: String?
    let httpMethod: HTTPMethod
    let parameters: [String: String]
    
    init(url: URL,
         path: String? = nil,
         httpMethod: HTTPMethod = .get,
         parameters: [String: String] = [:]) {
        self.url = url
        self.path = path
        self.httpMethod = httpMethod
        self.parameters = parameters
    }
}
