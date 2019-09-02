//
//  ViewController.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let dataSource = EmployeeDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "subtitleCell")
        dataSource.dataChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        tableView.dataSource = dataSource
        dataSource.getEmployees()
    }
}

