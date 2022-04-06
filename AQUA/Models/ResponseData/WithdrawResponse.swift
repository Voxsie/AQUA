//
//  WithdrawResponse.swift
//  LAVA
//
//  Created by Tagir Kabirov on 01.04.2022.
//

import Foundation
// MARK: - WithdrawResponse
struct WithdrawResponse: Codable {
    let status: Status?
    let sessionID, type: String?
    let payoffs: [Payoff?]?
    let error: WithdrawError?
    let serverTime: Int?

    enum CodingKeys: String, CodingKey {
        case status
        case sessionID = "session_id"
        case type, payoffs, error
        case serverTime = "server_time"
    }
}

// MARK: - WithdrawError
struct WithdrawError: Codable {
    let errorDescription: String?
    let code: Int?

    enum CodingKeys: String, CodingKey {
        case errorDescription = "description"
        case code
    }
}

// MARK: - Payoff
struct Payoff: Codable {
    let id, status: String?
    let amount: Int?
    let commission: Double?
}

enum Status: Codable {
    case integer(Int)
    case string(String)

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode(Int.self) {
            self = .integer(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(Status.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Commission"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .integer(let x):
            try container.encode(x)
        case .string(let x):
            try container.encode(x)
        }
    }
}
