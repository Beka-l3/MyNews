//
//  ImageService.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//


import Foundation
import UIKit

protocol ImageService: AnyObject {
    func fetchImage(
        with url: String,
        completion: @escaping (Result<UIImage, HTTPError>) -> Void
    ) -> Cancellable?
}


final class ImageServiceImp: ImageService {
    
    // MARK: - Properties
    
    private let urlSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = .init(
            memoryCapacity: Constants.memoryCapacity,
            diskCapacity: Constants.diskCapacity
        )
        let session = URLSession(configuration: configuration)
        return session
    }()
    
    static var shared: ImageServiceImp = .init()

    // MARK: - Lifecycle
    
    private init() {}
    
    // MARK: - Public
    
    @discardableResult
    func fetchImage(
        with url: String,
        completion: @escaping (Result<UIImage, HTTPError>) -> Void
    ) -> Cancellable? {
        if let image = UIImage(named: url) {
            completion(.success(image))
            return nil
        }
        
        guard let requestUrl = URL(string: url) else {
            completion(.failure(HTTPError.missingURL))
            return nil
        }

        
        let task = urlSession.dataTask(with: requestUrl) { data, _, _ in
            guard
                let data = data,
                let image = UIImage(data: data)
            else {
                DispatchQueue.main.async {
                    completion(.failure(HTTPError.noData))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(image))
            }
        }
        task.resume()
        return task
    }
}


// MARK: - Nested types

extension ImageServiceImp {
    private enum Constants {
        static let memoryCapacity: Int = 1024 * 1024 * 100
        static let diskCapacity: Int = 1024 * 1024 * 100
    }
}
