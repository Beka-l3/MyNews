//
//  NrtworkClientProtocol.swift
//  PeekMovie
//
//  Created by Bekzhan Talgat on 17.10.2022.
//

import Foundation

protocol NetworkClient {
    func processRequest<T: Decodable>(
        request: HTTPRequest,
        completion: @escaping (Result<T, HTTPError>) -> Void
    ) -> Cancellable?
}

protocol Cancellable {
    func cancel()
}

