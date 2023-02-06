//
//  NetworkServiceProtocol.swift
//  PeekMovie
//
//  Created by Bekzhan Talgat on 01.11.2022.
//

import Foundation


protocol NetworkService: AnyObject {
    @discardableResult
    func fetchNews(
        credentials: Int,
        completion: @escaping (Result<News, HTTPError>) -> Void
    ) -> Cancellable?
    
}

