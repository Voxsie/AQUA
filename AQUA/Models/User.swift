//
//  User.swift
//  AQUA
//
//  Created by Tagir Kabirov on 07.05.2022.
//

import Foundation
import Alamofire

class User {
    static let defaults = UserDefaults.standard
    
    static var login: String? {
        get {
            defaults.object(forKey: "UserLogin") as? String
        }
        set {
            defaults.set(newValue, forKey: "UserLogin")
        }
    }
    
    static var password: String? {
        get {
            defaults.object(forKey: "UserPassword") as? String
        }
        set {
            defaults.set(newValue, forKey: "UserPassword")
        }
    }
    
    static var token: String? {
        get {
            defaults.object(forKey: "UserToken") as? String
        }
        set {
            defaults.set(newValue, forKey: "UserToken")
        }
    }
    static var _wallets: [Wallet]? {
        get{
            return self.wallets
        }
        set{
            var orderedWallet: [Wallet] = []
            var rub, usd, eur: Wallet?
            
            for wallet in (newValue ?? []) {
                switch wallet.currency {
                case "RUB": rub = wallet
                case "USD": usd = wallet
                case "EUR": eur = wallet
                default: return
                }
            }
            if let r = rub { orderedWallet.append(r)}
            if let u = usd { orderedWallet.append(u)}
            if let e = eur { orderedWallet.append(e)}

            self.wallets = orderedWallet
        }
    }
    
    static var wallets: [Wallet]?
//    static var wallets: [Wallet]?{
//        get {
//            defaults.object(forKey: "UserWallets") as? [Wallet]
//        }
//        set {
//            defaults.set(newValue, forKey: "UserWallets")
//        }
//    }
    static var sessionID: String?
    
    enum typeOfAccount {
        case personal
        case business
    }
    
    static var accountType: typeOfAccount = .personal

}

