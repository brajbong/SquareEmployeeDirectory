//
//  EmployeeListIntegrationTests.swift
//  EmployeeDirectoryTests
//
//  Created by Rajbongshi, Bhaskar on 9/4/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import XCTest
@testable import EmployeeDirectory

class EmployeeListIntegrationTests: XCTestCase {
    var sut: EmployeeListViewController!
    override func setUp() {
        super.setUp()
        sut = EmployeeListViewController()
        sut.viewDidLoad()
    }
    
    func testEmployeeListViewControllerEmployeeDetailDisplaysCorrectly() {
        let employee = Employee(id: EmployeeData.expectedEmpId,
                                fullName: EmployeeData.expectedFullName,
                                phoneNumber: EmployeeData.expectedPhoneNumber,
                                emailAddress: EmployeeData.expectedEmailAddress,
                                biography: EmployeeData.expectedBiography,
                                photoUrlSmall: EmployeeData.expectedPhotoUrlSmall,
                                photoUrlLarge: EmployeeData.expectedPhotoUrlLarge,
                                team: EmployeeData.expectedTeam,
                                employeeType: EmployeeData.expectedEmployeeType)
        let viewModel = EmployeeViewModel(employeeService: EmployeeService(networking: NetworkService()))
        sut.dataSource.employeeVM = viewModel
        sut.dataSource.employeeVM.employees = [employee]
        sut.tableView.reloadData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! EmployeeCell
        XCTAssertEqual(cell.namelabel.text, EmployeeData.expectedFullName)
        XCTAssertEqual(cell.desclabel.text, EmployeeData.expectedBiography)
        XCTAssertEqual(cell.emailLabel.text, EmployeeData.expectedEmailAddress)
    }
    
    //MARK :- Utility methods
    private struct EmployeeData {
        static let expectedEmpId = "d8265dcd-1914-4f93-8068-07f5426f0866"
        static let expectedFullName = "Jack Dorsey"
        static let expectedPhoneNumber = "5554544932"
        static let expectedEmailAddress = "jdorsey.demo@squareup.com"
        static let expectedBiography = "I work for you."
        static let expectedPhotoUrlSmall = "https://s3.amazonaws.com/sq-mobile-interview/photos/f8fc3c8e-b8ed-41d8-9005-537cf657c169/small.jpg"
        static let expectedPhotoUrlLarge = "https://s3.amazonaws.com/sq-mobile-interview/photos/f8fc3c8e-b8ed-41d8-9005-537cf657c169/large.jpg"
        static let expectedTeam = "Core"
        static let expectedEmployeeType: Employee.EmployeeType = .FULL_TIME
    }
    
    private func makeEmployee(empId: String,
                              fullName: String,
                              phoneNumber: String,
                              emailAddress: String,
                              biography: String,
                              photoUrlSmall: String,
                              photoUrlLarge: String,
                              team: String,
                              employeeType: Employee.EmployeeType) -> Employee {
        return Employee(id: empId,
                        fullName: fullName,
                        phoneNumber: phoneNumber,
                        emailAddress: emailAddress,
                        biography: biography,
                        photoUrlSmall: photoUrlSmall,
                        photoUrlLarge: photoUrlLarge,
                        team: team,
                        employeeType: employeeType)
    }
}
