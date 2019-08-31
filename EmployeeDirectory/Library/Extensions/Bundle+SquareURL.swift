//
//  Bundle+SquareURL.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

extension Bundle {
    subscript(key: String) -> [String: String]? {
        return self.infoDictionary?[key] as? [String: String]
    }
}

extension Bundle {
    static private let squareRootKey = "Square"
    var employeesURL: String? {
        return self[Bundle.squareRootKey]?["employeesURL"] ?? nil
    }
}
