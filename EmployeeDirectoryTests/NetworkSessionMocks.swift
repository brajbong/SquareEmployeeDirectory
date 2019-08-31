//
//  NetworkSessionMocks.swift
//  EmployeeDirectoryTests
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation
@testable import EmployeeDirectory

class NetworkSessionMockCorrectURL: NetworkSessionable {
    var lastURL: URL?
    let success = true
    
    //discardableresult since we don't use the return value in tests
    @discardableResult
    func dataTask(with urlRequuest: URLRequest, completionHandler: @escaping Handler<Data>) -> URLSessionDataTask {
        defer { completionHandler(.success(Data.init())) }
        lastURL = urlRequuest.url
        return URLSessionDataTask()
    }
}

class NetworkSessionMockNetworkRequestMade: NetworkSessionable {
    var dataTask: DataTaskMockNetworkRequestMade?
    
    @discardableResult
    func dataTask(with urlRequuest: URLRequest, completionHandler: @escaping Handler<Data>) -> URLSessionDataTask {
        let newDataTask = DataTaskMockNetworkRequestMade(completionHandler: completionHandler)
        newDataTask.resume()
        dataTask = newDataTask
        return newDataTask
    }
}

//following dt mock is used in NetworkSessionMockNetworkRequestMade
class DataTaskMockNetworkRequestMade: URLSessionDataTask {
    var completionHandler: Handler<Data>
    var resumeWasCalled = false
    init(completionHandler: @escaping Handler<Data>) {
        self.completionHandler = completionHandler
    }
    
    override func resume() {
        resumeWasCalled = true
        completionHandler(.success(Data.init()))
    }
}

class NetworkSessionMockGetCorrectPresetData: NetworkSessionable {
    var testData: Data?
    
    @discardableResult
    func dataTask(with urlRequuest: URLRequest, completionHandler: @escaping Handler<Data>) -> URLSessionDataTask {
        defer { completionHandler(.success(testData!))}
        return DataTaskMockGetCorrectPresetData()
    }
}

//following dt mock is used in NetworkSessionMockGetCorrectPresetData
class DataTaskMockGetCorrectPresetData: URLSessionDataTask {
    override func resume() {
    }
}





