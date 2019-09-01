//
//  MockEmployeeService.swift
//  EmployeeDirectoryTests
//
//  Created by Rajbongshi, Bhaskar on 8/31/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation
@testable import EmployeeDirectory

class MockNetworkService {
    
    private func makeResponse(_ url: URL) -> Data {
        return try! Data(contentsOf: url)
    }
}

extension MockNetworkService: Networking {
    func fetch(resource: Resource, completion: @escaping (Result<Data, DataFetchError>) -> Void) {
        let url = resource.url
        completion(.success(makeResponse(url)))
    }
    
}
