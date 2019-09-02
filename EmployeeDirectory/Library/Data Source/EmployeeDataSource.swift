//
//  EmployeeDataSource.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/2/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import UIKit

class EmployeeDataSource: NSObject {
    var employeeVM = EmployeeViewModel(employeeService: EmployeeService(networking: NetworkService()))
    var dataChanged: (() -> Void)?
    
    func getEmployees() {
        employeeVM.getEmployees { [weak self] success in
            self?.dataChanged?()
        }
    }
}

extension EmployeeDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeVM.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!

        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: "subtitleCell") {
            cell = reuseCell
        } else {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "subtitleCell")
        }
        
        let employee = employeeVM.employees[indexPath.row]
        cell.textLabel?.text = employee.fullName
        cell.detailTextLabel?.text = employee.emailAddress
        return cell
    }
}
