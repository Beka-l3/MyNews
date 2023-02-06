//
//  FileCache.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import Foundation


final class FileCache<T: Codable> {
    
    // MARK: - Properties
    
    private let userDefaults: UserDefaults
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    // MARK: - Lifecycle
    
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
        self.encoder = JSONEncoder()
        self.decoder = JSONDecoder()
    }
    
    // MARK: - Public
    
    func insert(_ item: T, for key: String) throws {
        let encoded = try encoder.encode(item)
        userDefaults.set(encoded, forKey: key)
    }
    
    func get(for key: String) throws -> T? {
        guard let data = userDefaults.data(forKey: key) else {
            throw FileCacheError.itemNotFound
        }
        let unwrappedData = try decoder.decode(T.self, from: data)
        return unwrappedData
    }
    
    func remove(for key: String) {
        userDefaults.removeObject(forKey: key)
    }
}
