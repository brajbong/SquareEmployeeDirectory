//
//  Employees.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/1/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

struct Employees: Decodable {
    let employees: [Employee]?
    
    static func make(data: Data) -> Employees? {
        return try? JSONDecoder().decode(Employees.self, from: data)
    }
}
