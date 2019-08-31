//
//  TestNetworkCalls.swift
//  EmployeeDirectoryTests
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import XCTest

class NetworkTests: XCTestCase {
    //test that we actually request the url we asked for
    func testGetEmployeesLoadsCorrectUrl() {
        //given
        let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
        let networkSessionMock = NetworkSessionMockCorrectURL()
        let expectation = XCTestExpectation(description: "Get Employees: Correct URL used in request.")
        //when
        networkSessionMock.dataTask(with: URLRequest(url: url)) { result in
            XCTAssertEqual(url, networkSessionMock.lastURL)
            expectation.fulfill()
        }
        
        //then
        wait(for: [expectation], timeout: 5.0)
    }
    
    //test that a network call was actually started
    func testGetEmployeesCallsResume() {
        //given
        let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
        let networkSessionMock = NetworkSessionMockNetworkRequestMade()
        let expectation = XCTestExpectation(description: "Get Employees: Actual request is being made.")
        //when
        networkSessionMock.dataTask(with: URLRequest(url: url)) { result in
            XCTAssertFalse(networkSessionMock.dataTask?.resumeWasCalled ?? false)
            expectation.fulfill()
        }
        
        //then
        wait(for: [expectation], timeout: 5.0)
    }
    
    //test that we get back proper data
    func testGetEmployeesGetBackCorrectData() {
        //given
        let presetString = "Square employee list sample preset data"
        let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
        let networkSessionMock = NetworkSessionMockGetCorrectPresetData()
        networkSessionMock.testData = Data(presetString.utf8)
        let expectation = XCTestExpectation(description: "Get Employees: request gets back proper data.")
        
        //when
        networkSessionMock.dataTask(with: URLRequest(url: url)) { result in
            if case .success(let data) = result {
                XCTAssertEqual(String(decoding: data, as: UTF8.self), presetString)
                expectation.fulfill()
            }
        }
        
        //then
        wait(for: [expectation], timeout: 5.0)
    }
}
