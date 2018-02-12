//
//  UserWallet.swift
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

extension DatabaseManager {
 
    /// Wallet
    class Wallet: BaseModel {
        
        @objc dynamic var currency : String = ""
        @objc dynamic var amount: Double = 0

        override class func primaryKey() -> String {
            return "currency"
        }
    }
    
    // User
    class User: BaseModel {
        
        @objc dynamic var name : String = ""
        var wallets = List<Wallet>()

//        override class func primaryKey() -> String {
//            return "currency"
//        }
    }
}
