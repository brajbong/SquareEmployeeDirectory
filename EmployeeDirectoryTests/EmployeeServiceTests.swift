//
//  EmployeeServiceTests.swift
//  EmployeeDirectoryTests
//
//  Created by Rajbongshi, Bhaskar on 8/31/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import XCTest
@testable import EmployeeDirectory

class EmployeeServiceTests: XCTestCase {
    func testEmployeesCorrectResponse() {
        let expectation = XCTestExpectation(description: "Employee service: correct response.")
        makeSUT().fetch(resource: Resource(url: makeURL(.correct))) { result in
            guard case .success(let data) = result  else {
                XCTFail()
                return
            }
            guard let employees: Employees = Employees.make(data: data) else {
                XCTFail()
                return
            }
            
            guard let employeeArr: [Employee] = employees.employees else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(employeeArr.count, 2)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testEmployeesMalformedResponse() {
        let expectation = XCTestExpectation(description: "Employee service: malformed response.")
        makeSUT().fetch(resource: Resource(url: makeURL(.malformed))) { result in
            guard case .success(let data) = result  else {
                XCTFail()
                return
            }
            
            XCTAssertNil(Employees.make(data: data))
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

extension EmployeeServiceTests {
    private enum ResponseType {
        case correct
        case malformed
    }
    
    // MARK :- Utility
    private func makeSUT() -> Networking {
        return MockNetworkService()
    }
    
    private func makeURL(_ responseType: ResponseType) -> URL {
        switch responseType {
        case .correct:
            return url(for: "employees")
        case .malformed:
            return url(for: "employees_malformed")
        }
    }
    
    private func url(for fileName: String) -> URL {
        let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json", subdirectory: "StubbedJSONResponses")!
        return url
    }
}
