//
//  AuthorizationResponse.swift
//  LAVA
//
//  Created by Tagir Kabirov on 10.03.2022.
//

import Foundation

// MARK: - RegistrationResponse
struct RegistrationResponse: Codable {
    let data: RegData?
    let error: RegResponseError?
    let status, serverTime: Int?

    enum CodingKeys: String, CodingKey {
        case data, error, status
        case serverTime = "server_time"
    }
}

// MARK: - Data
struct RegData: Codable {
    let status: String?
    let accessToken: String?
    let next: Next?

    enum CodingKeys: String, CodingKey {
        case status
        case accessToken = "access_token"
        case next
    }
}

// MARK: - Next
struct Next: Codable {
    let message, type, sessionID: String?

    enum CodingKeys: String, CodingKey {
        case message, type
        case sessionID = "session_id"
    }
}

// MARK: - Error
struct RegResponseError: Codable {
    let errorDescription: String?
    let code: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case errorDescription = "description"
        case code, type
    }
}

