//
//  EmployeeService.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/1/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

final class EmployeeService {
    private let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func fetchEmployees(completion: @escaping ([Employee]) -> Void) {
        let resource = Resource(url: URL(string: Bundle.employeesURL)!)
        return networking.fetch(resource: resource, completion: { result in
            if case .success(let data) = result {
                completion(Employees.make(data: data)?.employees ?? [])
            }
        })
    }
}
