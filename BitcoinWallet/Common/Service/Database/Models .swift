//
//  BaseModel.swift
//
//  Created by Romilson Nunes on 24/01/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


// MARK: - Wallet

class DBWallet: Object {
    @objc dynamic var currency : String = ""
    @objc dynamic var amount: Double = 0
    
    override class func primaryKey() -> String {
        return "currency"
    }
}

//// User
//class DBUser: BaseModel {
//    @objc dynamic var name : String = ""
//    var wallets = List<DBWallet>()
//}


