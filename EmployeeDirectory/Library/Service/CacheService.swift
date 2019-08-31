//
//  CacheService.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

final class CacheService {
    private let memCache = NSCache<NSString, NSData>()
    private let diskPath: URL
    private let fileManager: FileManager
    private let serialQueue = DispatchQueue(label: "br.square")
    
    init(fileManager: FileManager = FileManager.default) {
        self.fileManager = fileManager
        do {
            let docDir = try fileManager.url(for: .documentDirectory,
                                             in: .userDomainMask,
                                             appropriateFor: nil,
                                             create: true)
            diskPath = docDir.appendingPathComponent("square")
            try createDirectoryIfNeeded()
        } catch {
            fatalError()
        }
    }
    
    func load(key: String, completion: @escaping (Data?) -> Void) {
        serialQueue.async {
            //object present in memcache
            if let data = self.memCache.object(forKey: key as NSString) {
                completion(data as Data)
                return
            }
            
            //object present in disk
            if let data = try? Data(contentsOf: self.filePath(key: key)) {
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
            try? data.write(to: self.filePath(key: key))
        }
    }
}

extension CacheService {
    fileprivate func createDirectoryIfNeeded() throws {
        if fileManager.fileExists(atPath: diskPath.path) {
            try fileManager.createDirectory(at: diskPath,
                                            withIntermediateDirectories: false,
                                            attributes: nil)
        }
    }
    
    fileprivate func filePath(key: String) -> URL {
        return diskPath.appendingPathComponent(key)
    }
}
