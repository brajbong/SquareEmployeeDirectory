//
//  CacheService.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

final class DiskCache {
    let url: URL
    let fileManager: FileManager
    
    fileprivate init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
        do {
            let docDir = try fileManager.url(for: .documentDirectory,
                                             in: .userDomainMask,
                                             appropriateFor: nil,
                                             create: true)
            url = docDir.appendingPathComponent("square")
            createDirectoryIfNeeded()
        } catch {
            fatalError()
        }
    }
    
    fileprivate func getData(for key: String) -> Data? {
        return try? Data(contentsOf: getFilePath(for: key))
    }
    
    fileprivate func write(data: Data, key: String) {
        try? data.write(to: getFilePath(for: key))
    }
    
    private func getFilePath(for key: String) -> URL {
        return url.appendingPathComponent(key)
    }
}

extension DiskCache {
    fileprivate func createDirectoryIfNeeded() {
        guard fileManager.fileExists(atPath: url.path) else {
            return
        }
        
        try? fileManager.createDirectory(at: url,
                                         withIntermediateDirectories: false, attributes: nil)
    }
}

final class CacheService {
    private let memCache = NSCache<NSString, NSData>()
    private let diskCache: DiskCache? = DiskCache()
    private let serialQueue = DispatchQueue(label: "br.square")
    
    func load(key: String, completion: @escaping (Data?) -> Void) {
        serialQueue.async {
            //object present in memcache
            if let data = self.memCache.object(forKey: key as NSString) {
                completion(data as Data)
                return
            }
            
            //object present in disk
            if let data = self.diskCache?.getData(for: key) {
                //set it in memcache
                self.memCache.setObject(data as NSData, forKey: key as NSString)
                completion(data)
                return
            }
            
            completion(nil)
        }
    }
    
    func save(data: Data, key: String, completion: (() -> Void)? = nil) {
        serialQueue.async {
            self.memCache.setObject(data as NSData, forKey: key as NSString)
            self.diskCache?.write(data: data, key: key)
        }
    }
}
