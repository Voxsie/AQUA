//
//  CodeConfirmResponse.swift
//  LAVA
//
//  Created by Tagir Kabirov on 11.03.2022.
//

import Foundation

// MARK: - CodeConfirmResponse
struct CodeConfirmResponse: Codable {
    let data: CodeConfirmData?
    let error: CodeError?
    let status, serverTime: Int

    enum CodingKeys: String, CodingKey {
        case data, error, status
        case serverTime = "server_time"
    }
}

// MARK: - DataClass
struct CodeConfirmData: Codable {
    let status, sessionID, jwt: String?

    enum CodingKeys: String, CodingKey {
        case status
        case sessionID = "session_id"
        case jwt
    }
}

// MARK: - Error
struct CodeError: Codable {
    let errorDescription: String
    let code: Int

    enum CodingKeys: String, CodingKey {
        case errorDescription = "description"
        case code
    }
}
