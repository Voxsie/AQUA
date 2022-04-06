//
//  TransferResponseswift.swift
//  LAVA
//
//  Created by Илья Желтиков on 28.03.2022.
//

import Foundation

// MARK: - TransferResponse
struct TransferResponse: Codable {
    let data: TransferData?
    let error: TransferError?
    let status, serverTime: Int?

    enum CodingKeys: String, CodingKey {
        case data, error, status
        case serverTime = "server_time"
    }
}

// MARK: - DataClass
struct TransferData: Codable {
    let status,sessionID, id: String?
    let amount, commission: Int?
    
    enum CodingKeys: String, CodingKey {
        case status
        case sessionID = "session_id"
        case id, amount, commission
    }
}

// MARK: - Error
struct TransferError: Codable {
    let errorDescription: String?
    let code: Int?
    let type: String?
   

    enum CodingKeys: String, CodingKey {
        case errorDescription = "description"
        case code, type
    }
}
