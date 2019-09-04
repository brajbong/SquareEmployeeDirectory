//
//  ImageService.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/3/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import UIKit

final class ImageService {
    private let networkService: Networking
    private let cacheService: CacheService
    
    init(networkService: Networking = NetworkService(), cacheService: CacheService = CacheService()) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
    
    func fetchImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        //try loading from cache first
        cacheService.load(key: url.absoluteString) { [weak self] cachedData in
            if let data = cachedData, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                //request from network
                let resource = Resource(url: url)
                guard let self = self else {
                    return
                }
                self.networkService.fetch(resource: resource, completion: { remoteDataResult in
                    if case .success(let data) = remoteDataResult {
                        if let image = UIImage(data: data) {
                            //save in cache
                            self.cacheService.save(data: data, key: url.absoluteString)
                            DispatchQueue.main.async {
                                completion(image)
                            }
                        }
                    }
                })
            }
        }
    }
    
}

