//
//  WalletListResponse.swift
//  LAVA
//
//  Created by Tagir Kabirov on 17.03.2022.
//

import Foundation

// MARK: - WalletListResponse
struct WalletListResponse: Codable {
    let data: [Wallet]?
    let error: String?
    let status, serverTime: Int?

    enum CodingKeys: String, CodingKey {
        case data, error, status
        case serverTime = "server_time"
    }
}

// MARK: - Datum
struct Wallet: Codable {
    let account, currency, balance: String
}
