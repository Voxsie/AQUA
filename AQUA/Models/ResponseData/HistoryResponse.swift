//
//  HistoryResponse.swift
//  LAVA
//
//  Created by Tagir Kabirov on 18.03.2022.
//

import Foundation

// MARK: - HistoryResponse
struct HistoryResponse: Codable {
    let data: HistoryData?
    let error: String?
    let status, serverTime: Int?

    enum CodingKeys: String, CodingKey {
        case data, error, status
        case serverTime = "server_time"
    }
}

// MARK: - DataClass
struct HistoryData: Codable {
    let items: [Item?]?
    let count: String?
}

// MARK: - Item
struct Item: Codable {
    let id, createdAt: String?
    let createdDate: String?
    let amount, status, transferType, comment: String?
    let method, currency, account, service: String?
    let title: String?
    let commission: Commission?
    let type, sender, receiver: String?

    enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case createdDate = "created_date"
        case amount, status
        case transferType = "transfer_type"
        case comment, method, currency, account, service, title, commission, type, sender, receiver
    }
}

enum Commission: Codable {
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
        throw DecodingError.typeMismatch(Commission.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for Commission"))
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
