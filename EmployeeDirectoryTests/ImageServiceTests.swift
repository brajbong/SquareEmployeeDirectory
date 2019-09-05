//
//  ImageServiceTests.swift
//  EmployeeDirectoryTests
//
//  Created by Rajbongshi, Bhaskar on 9/4/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import XCTest
@testable import EmployeeDirectory

class ImageServiceTests: XCTestCase {
    var sut = ImageService(networkService: NetworkService(), cacheService: CacheService())
    let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview/photos/f8fc3c8e-b8ed-41d8-9005-537cf657c169/small.jpg")!
    
    func testImageServiceDownloadSuccess() {
        let expectation = XCTestExpectation(description: "ImageService: download success!")
        var downloadedImage: UIImage?
        sut.fetchImage(for: url) {
            downloadedImage = $0
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5.0)
        XCTAssertNotNil(downloadedImage)
    }
}


