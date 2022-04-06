//
//  AuthorizationResponse.swift
//  LAVA
//
//  Created by Tagir Kabirov on 10.03.2022.
//

import Foundation

// MARK: - AuthorizationResponse
struct AuthorizationResponse: Codable {
    let data: AuthData?
    let error: AuthResponseError?
    let status, serverTime: Int

    enum CodingKeys: String, CodingKey {
        case data, error, status
        case serverTime = "server_time"
    }
}

// MARK: - Data
struct AuthData: Codable {
    let status, accessToken: String

    enum CodingKeys: String, CodingKey {
        case status
        case accessToken = "access_token"
    }
}

// MARK: - Error
struct AuthResponseError: Codable {
    let errorDescription: String
    let code: Int

    enum CodingKeys: String, CodingKey {
        case errorDescription = "description"
        case code
    }
}
