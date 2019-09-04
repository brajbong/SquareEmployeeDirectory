//
//  ViewController.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dataSource = EmployeeDataSource()
    private (set) var tableView: UITableView!
    private let emptyView = EmptyView(text: "No employees found!")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
        setupEmptyView()
        dataSource.dataChanged = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.animateEmptyView()
            }
        }

        dataSource.getEmployees()
    }
    
    private func animateEmptyView() {
        UIView.animate(withDuration: 0.25, animations: { [weak self] in
            self?.emptyView.alpha = self?.dataSource.employeeVM.employees.isEmpty ?? true ? 1 : 0
        })
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero)
        view.addSubview(tableView)
        NSLayoutConstraint.pin(view: tableView, toEdgesOf: view)
        tableView.dataSource = dataSource
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "EmployeeCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    private func setupEmptyView() {
        view.addSubview(emptyView)
        NSLayoutConstraint.pin(view: emptyView, toEdgesOf: view)
        emptyView.alpha = 0
    }
}

