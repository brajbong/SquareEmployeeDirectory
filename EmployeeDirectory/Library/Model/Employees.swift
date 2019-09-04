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
        do {
            print(String(data: data, encoding: .utf8)!)
            return try JSONDecoder().decode(Employees.self, from: data)
        } catch {
            print("error is: \(error.localizedDescription)")
        }
        return nil
        //return try? JSONDecoder().decode(Employees.self, from: data)
    }
}
