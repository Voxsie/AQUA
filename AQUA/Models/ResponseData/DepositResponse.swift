//
//  DepositResponse.swift
//  LAVA
//
//  Created by Илья Желтиков on 04.04.2022.
//

import Foundation

struct DepositResponse: Codable {
    let data: DepositData?
    let error: Error?
    let status: Int
    let serverTime: Int
}


struct PaymentData: Codable {
    let fingerprint: Bool?
    let type: String
    let paymentID: String?
    let link: String?
}

struct DepositData: Codable {
    let paymentData: [PaymentData]?
    let paymentStatus: String
    let paymentID: String?
}


struct Error: Codable {
    let description: String
    let code: Int
    let type: String
}



