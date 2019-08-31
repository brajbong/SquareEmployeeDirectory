//
//  URLSession+Extension.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

typealias Handler<T> = (Result<T, DataFetchError>) -> Void

extension URLSession: NetworkSessionable {
    func dataTask(with urlRequest: URLRequest,
                  completionHandler: @escaping Handler<Data>) -> URLSessionDataTask {
        let dt = dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completionHandler(.failure(.badResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                self.isResponseOK(response) else {
                    completionHandler(.failure(.badResponse))
                    return
            }
            
            guard let data = data else {
                completionHandler(.failure(.badData))
                return
            }
            
            completionHandler(.success(data))
        }
        
        dt.resume()
        return dt
    }
    
}

extension URLSession {
    fileprivate func isResponseOK(_ response: HTTPURLResponse) -> Bool {
        switch response.statusCode {
        case 200...299:
            return true
        default:
            return false
        }
    }
}
