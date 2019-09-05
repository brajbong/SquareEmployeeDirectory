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
    private var squareRootKey: [String: String] {
        let squareRootKey: [String: String] = self["Square"]!
        return squareRootKey
    }
    
    private var employeesURL: String {
        return squareRootKey["employeesURL"]!
    }
    
    static let employeesURL = Bundle.main.employeesURL
}
