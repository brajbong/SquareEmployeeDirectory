//
//  NetworkSessionable.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

protocol NetworkSessionable {
    @discardableResult
    func dataTask(with urlRequuest: URLRequest, completionHandler: @escaping Handler<Data>) -> URLSessionDataTask
}
