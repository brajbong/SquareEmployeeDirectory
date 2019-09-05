//
//  CacheServiceTests.swift
//  EmployeeDirectoryTests
//
//  Created by Rajbongshi, Bhaskar on 9/4/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import XCTest
@testable import EmployeeDirectory

class CacheServiceTests: XCTestCase {
    let sut = CacheService()
    let key = "http://a-url.com"
    var expectedData: Data?
    let expectedString = "An example string"
    var obtainedString: String?
    
    func testLoadingWithoutSavingReturnsNilFromCache() {
        let expectation = XCTestExpectation(description: "Cache- load without save.")
        sut.load(key: key) { [weak self] data in
            guard let self = self else {
                XCTFail()
                return
            }
            
            self.expectedData = data
            expectation.fulfill()
        }
        
        XCTAssertNil(expectedData)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSaveAndLoadFromCacheSuccess() {
        let expectation = XCTestExpectation(description: "Cache- save and then load.")
        sut.save(data: Data(expectedString.utf8), key: key)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.sut.load(key: self.key) { [weak self] data in
                guard let self = self,
                    let data = data else {
                        XCTFail()
                        return
                }
                
                self.obtainedString = String(data: data, encoding: .utf8)!
                XCTAssertEqual(self.expectedString, self.obtainedString)
                expectation.fulfill()
            }
            
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}
