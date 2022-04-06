//
//  PayoffMethodsResponse.swift
//  LAVA
//
//  Created by Tagir Kabirov on 04.04.2022.
//

import Foundation

// MARK: - PayoffMethods
struct PayoffMethodsResponse: Codable {
    let tariffs, services: [String : String]?
    let serverTime: Int?

    enum CodingKeys: String, CodingKey {
        case tariffs, services
        case serverTime = "server_time"
    }
}
