//
//  Request.swift
//  AQUA
//
//  Created by Tagir Kabirov on 10.04.2022.
//
import Foundation
import Alamofire
import UIKit
import CloudKit

class Request {
    
    let postRequest = Request(pathToTheFolder: "", method: .post)
    private let apiURL = "https://aquatest/api/"
    
    //MARK: - variables
    private var path: String
    private var method: HTTPMethod
    private var URL: String {
        self.apiURL + self.path
    }
    private var parameters: [String: Any]?
    private var headers: HTTPHeaders?
    
    //MARK: - typealias
    typealias RegistrationHandler = (RegistrationResponse?) -> Void
    typealias AccessTokenHandler  = (String?, Bool?, Bool?, String?) -> Void
    typealias UserExistenceHandler = (Bool) -> Void
    typealias WalletListHandler = ([Wallet]?) -> Void
    typealias HistoryHandler = (HistoryData?, Int) -> Void
    typealias TransferHandler = (TransferResponse?) -> Void
    typealias WithdrawHandler = (WithdrawResponse?) -> Void
    typealias PayoffMethodsHandler = (PayoffMethodsResponse?) -> Void
    typealias ConfigPaymentsHandler = (ConfigPaymentsResponse?) -> Void
    typealias PaymentHandler = (PaymentProcessResponse?) -> Void
    
    //MARK: - initialiser
    init(pathToTheFolder path:String, method: HTTPMethod) {
        self.path = path
        self.method = method
    }
}


//Get User Token Request
extension Request {
    func getUserToken(completionHandler: @escaping AccessTokenHandler) {
        self.path = "auth"
        parameters = getUserInformationParameters()
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
                case .success(let data):
                    if let data = data, let response = try? JSONDecoder().decode(RegistrationResponse.self, from: data){
                        if response.status == 200{
                            completionHandler(response.data?.accessToken, response.data?.next?.type == "auth_two_fa_confirm", response.data?.next?.type == "email_confirm", response.data?.next?.sessionID  )
                        }
                        else {
                            completionHandler(nil, nil, nil, nil)
                        }
                    }
                    else{
                        completionHandler(nil, nil, nil, nil)
                    }
                case .failure(_):
                    completionHandler(nil, nil, nil, nil)
            }
        }
    }
}


//User Exists request
extension Request {
    func userRegistration(siteName: String?, completionHandler: @escaping RegistrationHandler) {
        self.path = "signup"
        parameters = getUserRegistrationParameters(siteName: siteName)
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
                case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode(RegistrationResponse.self, from: data){
                    completionHandler(response)
                }
                else{
                    completionHandler(nil)
                }
                case .failure(_):
                    completionHandler(nil)
            }
        }
    }
    
    func isUserExists(completionHandler: @escaping UserExistenceHandler) {
        self.path = "signup"
        parameters = getUserCheckParameters()
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
                case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode(RegistrationResponse.self, from: data){
                    if response.error?.errorDescription != "Пользователь с такой почтой уже существует"{
                        completionHandler(false)
                    }
                    else {
                        completionHandler(true)
                    }
                }
                else{
                    completionHandler(true)
                }
                case .failure(_):
                    completionHandler(true)
            }
        }
    }
}

//Code confirm request
extension Request {
    
    func codeConfirm(sessionId: String, code: String, completionHandler: @escaping (Bool, String?) -> ()) {
        self.path = "code_confirm"
        parameters = getCodeConfirmParam(sessionID: sessionId, code: code)
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default).response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode(CodeConfirmResponse.self, from: data){
                    if response.status == 200 {
                        completionHandler(true, response.data?.jwt)
                    }
                    else{
                        completionHandler(false, nil)
                    }
                }
            case .failure(_):
                completionHandler(false, nil)
            }
        }
    }
}

//Get user parameters functions
extension Request {
    
    private func getUserInformationParameters() -> [String: Any] {
        return [
            "login": "\(User.login ?? "")",
            "password": "\(User.password ?? "")"
        ]
    }
    
    private func getUserCheckParameters() -> [String: Any] {
        return [
            "login": "\(User.login ?? "")",
            "password": "1"
        ]
    }
    
    private func getUserRegistrationParameters(siteName: String?) -> [String: Any] {
        let type = User.accountType == .business ? "1" : "0"
        return [
            "is_business": type,
            "login": "\(User.login ?? "")",
            "password": "\(User.password ?? "")",
            "merchant": "\(siteName ?? "")"
        ]
    }
    
    
    private func getCodeConfirmParam(sessionID: String, code:String) -> [String: Any] {
        [
            "session_id": "\(sessionID)",
            "code": "\(code)"
        ]
    }
    
    private func getWalletListHeaders() -> HTTPHeaders{
        [
            "authorization": "\(User.token ?? "")"
        ]
    }
    
    private func getTokenHeaders() -> HTTPHeaders {
        [
            "authorization": "\(User.token ?? "")"
        ]
    }
    private func getReloadHistoryParameters(offset: Int) -> [String: Any] {
        [
            "offset" : offset
        ]
    }
    private func getTransferParameters(from currentAccount: String, to beneficiarysAccount: String, amount: String, comment: String, sessionId: String?, code: String?) -> [String: Any] {
        [
            "account_from" : currentAccount,
            "account_to" : beneficiarysAccount,
            "amount" : amount,
            "comment" : comment,
            "session_id" : sessionId ?? "",
            "code" : code ?? ""
        ]
    }
    private func getWithdrawParameters(from currentAccount: String, to walletTo: String, amount: String, subtract: Bool, service: String, sessionId: String?, code: String?) -> [String: Any] {
        [
            "account": currentAccount,
            "wallet_to": walletTo,
            "amount": amount,
            "subtract": subtract ? "-" : "+",
            "service": service,
            "session_id": sessionId ?? "",
            "code": code ?? ""
        ]
    }
    
    private func getPaymentParameters(to currentAccount: String, amount: String, service: String) -> [String: Any] {
        [
            "wallet_to": currentAccount,
            "amount": amount,
            "service": service
        ]
    }
}

extension Request {
    func getWalletList(completionHandler: @escaping WalletListHandler) {
        self.path = "wallet/list"
        headers = getTokenHeaders()
        
        AF.request(self.URL, method: self.method,  headers: self.headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode( WalletListResponse.self, from: data) {
                    completionHandler(response.data)
                }
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
}

extension Request {
    func getTransactionHistory(completionHandler: @escaping HistoryHandler) {
        self.path = "finance/history"
        headers = getTokenHeaders()
        
        AF.request(self.URL, method: self.method,  headers: self.headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode( HistoryResponse.self, from: data) {
                    completionHandler(response.data, Int(response.data?.count ?? "0") ?? 0 )
                }
            case .failure(_):
                completionHandler(nil, 0)
            }
        }
        
    }
    
    func reloadHistory(offset: Int, completionHandler: @escaping HistoryHandler){
        self.path = "finance/history"
        self.headers = getTokenHeaders()
        self.parameters = getReloadHistoryParameters(offset: offset)
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default, headers: self.headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode( HistoryResponse.self, from: data) {
                    completionHandler(response.data, Int(response.data?.count ?? "0") ?? 0)
                }
            case .failure(_):
                completionHandler(nil, 0)
            }
        }
    }
}

extension Request {
    func transfer(from currentAccount: String, to beneficiarysAccount: String, amount: String, comment: String, sessionId: String?, code: String?, completionHandler: @escaping TransferHandler){
        self.path = "finance/transfer"
        self.headers = getTokenHeaders()
        self.parameters = getTransferParameters(from: currentAccount, to: beneficiarysAccount, amount: amount, comment: comment, sessionId: sessionId, code: code)
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default, headers: self.headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode( TransferResponse.self, from: data) {
                    completionHandler(response)
                }
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
    
    func withdraw(from currentAccount: String, to walletTo: String, amount: String, subtract: Bool, service: String, sessionId: String?, code: String?, completionHandler: @escaping  WithdrawHandler){
        self.path = "finance/withdraw"
        self.headers = getTokenHeaders()
        self.parameters = getWithdrawParameters(from: currentAccount, to: walletTo, amount: amount, subtract: subtract, service: service, sessionId: sessionId, code: code)
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default, headers: self.headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode( WithdrawResponse.self, from: data) {
                    completionHandler(response)
                }
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
    
    func payoffMethods(completionHandler: @escaping  PayoffMethodsHandler){
        self.path = "finance/config/payoff-methods"
        self.headers = getTokenHeaders()
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default, headers: self.headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode( PayoffMethodsResponse.self, from: data) {
                    completionHandler(response)
                }
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
}

extension Request {
    func configPayments(completionHandler: @escaping ConfigPaymentsHandler) {
        self.path = "finance/config/payments"
        self.headers = getTokenHeaders()
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default, headers: self.headers).response {response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode(ConfigPaymentsResponse.self, from: data) {
                    completionHandler(response)
                }
            case .failure(_):
                completionHandler(nil)
            }
        }
    }
}

extension Request {
    func payment(to currentAccount: String, amount: String, service: String, completionHandler: @escaping PaymentHandler) {
        self.path = "payment/process"
        self.headers = getTokenHeaders()
        self.parameters = getPaymentParameters(to: currentAccount, amount: amount, service: service)
        
        AF.request(self.URL, method: self.method, parameters: self.parameters, encoding: JSONEncoding.default, headers: self.headers).response { response in
            switch response.result {
            case .success(let data):
                if let data = data, let response = try? JSONDecoder().decode(PaymentProcessResponse.self, from: data) {
                    completionHandler(response)
                }
            case .failure(_):
                completionHandler(nil)
            }
        }

    }
}
