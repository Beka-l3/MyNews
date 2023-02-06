//
//  Source.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import Foundation


struct Source: Codable {
    var id: String? = nil
    var name: String? = nil

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}

// MARK: - Nested types

extension Source {
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
