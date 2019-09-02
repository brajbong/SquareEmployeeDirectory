//
//  EmployeeViewModel.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/2/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

class EmployeeViewModel {
    var employees = [Employee]()
    private var employeeService: EmployeeService
    
    init(employeeService: EmployeeService) {
        self.employeeService = employeeService
    }
    
    func getEmployees(completion: @escaping (Bool) -> Void) {
        employeeService.fetchEmployees { [weak self] employees in
            guard let self = self else { return }
            self.employees = employees
            return !self.employees.isEmpty ? completion(true): completion(false)
        }
    }
}
