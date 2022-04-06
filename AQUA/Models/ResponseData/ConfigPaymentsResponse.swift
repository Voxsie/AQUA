//
//  ConfigPaymentsResponse.swift
//  LAVA
//
//  Created by Илья Желтиков on 05.04.2022.
//

import Foundation

struct ConfigPaymentsResponse: Codable {
    let tariffs, services: [String : String]?
    let serverTime: Int?

    enum CodingKeys: String, CodingKey {
        case tariffs, services
        case serverTime = "server_time"
    }
}
