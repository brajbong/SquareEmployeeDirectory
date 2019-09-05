//
//  EmployeeListViewControllerTests.swift
//  EmployeeDirectoryTests
//
//  Created by Rajbongshi, Bhaskar on 9/3/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import XCTest
@testable import EmployeeDirectory

class EmployeeListViewControllerTests: XCTestCase {
    var sut: EmployeeListViewController!

    override func setUp() {
        super.setUp()
        sut = EmployeeListViewController()
        sut.viewDidLoad()
    }
    
    func testEmployeeListViewControllerHasATableView() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testEmployeeListViewControllerHasDataSourceConformingToProtocol() {
        XCTAssertNotNil(sut.dataSource)
        XCTAssertTrue(sut.dataSource.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(sut.dataSource.responds(to: #selector(sut.dataSource.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(sut.dataSource.responds(to: #selector(sut.dataSource.tableView(_:cellForRowAt:))))
    }
    
    func testEmployeeListViewControllerCustomTableViewCellHasReuseIdentifier() {
        sut.dataSource.employeeVM = makeViewModelAndEmployees(count: 1)
        sut.tableView.reloadData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EmployeeCell
        let actualReuseIdentifier = cell.reuseIdentifier
        let expectedIdentifier = "EmployeeCell"
        XCTAssertEqual(actualReuseIdentifier, expectedIdentifier)
    }
    
    func testEmployeeListViewControllerNumberOfEmployeesInTableViewIsCorrect() {
        sut.dataSource.employeeVM = makeViewModelAndEmployees(count: 2)
        let expectedNumOfEmployees = 2
        let actualNumOfEmployees = sut.tableView.numberOfRows(inSection: 0)
        XCTAssertEqual(expectedNumOfEmployees, actualNumOfEmployees)
        
    }
    
    //MARK: - Utility methods
    private func makeViewModelAndEmployees(count: Int) -> EmployeeViewModel {
        let viewModel = EmployeeViewModel(employeeService: EmployeeService(networking: NetworkService()))
        for _ in 0..<count {
            viewModel.employees.append(Employee())
        }
        return viewModel
    }
}

