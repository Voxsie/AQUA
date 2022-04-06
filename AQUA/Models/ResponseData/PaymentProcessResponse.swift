//
//  PaymentProcessResponse.swift
//  LAVA
//
//  Created by Tagir Kabirov on 06.04.2022.
//

import Foundation

// MARK: - Empty
struct PaymentProcessResponse: Codable {
    let data: PaymentResponseData?
    let error: PaymentError?
    let status, serverTime: Int?

    enum CodingKeys: String, CodingKey {
        case data, error, status
        case serverTime = "server_time"
    }
}

// MARK: - DataClass
struct PaymentResponseData: Codable {
    let paymentData: PaymentOperationData?
    let paymentStatus, paymentID: String?

    enum CodingKeys: String, CodingKey {
        case paymentData = "payment_data"
        case paymentStatus = "payment_status"
        case paymentID = "payment_id"
    }
}

// MARK: - PaymentData
struct PaymentOperationData: Codable {
    let fingerprint: Bool?
    let type: String?
    let link: String?
}

// MARK: - Error
struct PaymentError: Codable {
    let errorDescription: String?
    let code: Int?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case errorDescription = "description"
        case code, type
    }
}
