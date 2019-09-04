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
    
    func getEmployees(completion: @escaping (Result<Bool, DataFetchError>) -> Void) {
        employeeService.fetchEmployees { [weak self] result in
            guard let self = self else { return }
            if case .success(let employees) = result {
                self.employees = employees
                completion(.success(true))
            }
            
            if case .failure(let error) = result {
                completion(.failure(error))
            }
        }
    }
    
}
