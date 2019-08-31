//
//  Networking.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

enum DataFetchError: Error {
    case badConnection
    case badData
    case badURL
    case badResponse
}

protocol Networking {
    func fetch(resource: Resource, completion: @escaping (Result<Data, DataFetchError>) -> Void)
}
