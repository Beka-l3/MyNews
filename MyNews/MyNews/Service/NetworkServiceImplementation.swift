//
//  NetworkServiceImplementation.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import Foundation

final class NetworkServiceImplementation: NetworkService {
        
    private let networkClient: NetworkClient
    private let token: String = "73f7c5a473254b37b5805b0ecbded490"
    
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }

    
    func fetchNews(credentials: Int, completion: @escaping (Result<News, HTTPError>) -> Void) -> Cancellable? {
        networkClient.processRequest(
            request: createFetchNewsRequest(paging: credentials),
            completion: completion
        )
    }
    
    
    
//  MARK: - RequestCreator
    private func createFetchNewsRequest(paging: Int) -> HTTPRequest {
        let to = Calendar.current.date(byAdding: .day, value: -paging, to: Date())!
        let from = Calendar.current.date(byAdding: .day, value: -(paging + 1), to: to)!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return HTTPRequest(
            route: "https://newsapi.org/v2/everything",
            headers: [
                token: "X-Api-Key",
            ],
            queryItems: [
                ("q","tesla"),
                ("from", dateFormatter.string(from: from)),
                ("to", dateFormatter.string(from: to)),
                ("language", "en"),
                ("pageSize", "\(20)")
            ],
            httpMethod: .get
        )
        
    }
}
