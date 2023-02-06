//
//  Articles.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//
import Foundation

struct Article: Codable {
    var source: Source? = nil
    var author: String? = nil
    var title: String? = nil
    var description: String? = nil
    var url: String? = nil
    var urlToImage: String? = nil
    var publishedAt: String? = nil
    var content: String? = nil
    var viewCount: Int = 0
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        source = try values.decodeIfPresent(Source.self, forKey: .source)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
        publishedAt = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        content = try values.decodeIfPresent(String.self, forKey: .content)
    }
}

// MARK: - Nested types

extension Article {
    enum CodingKeys: String, CodingKey {
        case source = "source"
        case author = "author"
        case title  = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
}
