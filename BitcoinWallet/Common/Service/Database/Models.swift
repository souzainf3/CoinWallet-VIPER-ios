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

class DBTransaction: Object {
    @objc dynamic var identifier: String = ""
    @objc dynamic var type: Int = 0 // BUY = 0 | SELL = 1 | EXCHANGE = 2
    @objc dynamic var operation: Int = 0 // Debit = 0 | Credit = 1
    @objc dynamic var amount: Double = 0.0
    @objc dynamic var date: Date = Date()
    @objc dynamic var currency: String = ""

    override class func primaryKey() -> String {
        return "identifier"
    }

}

extension DBTransaction {
    convenience init(identifier: String, type: Int, operation: Int, amount: Double, date: Date, currency: String) {
        self.init()
        self.identifier = identifier
        self.type = type
        self.operation = operation
        self.amount = amount
        self.date = date
        self.currency = currency
    }
}

//// User
//class DBUser: BaseModel {
//    @objc dynamic var name : String = ""
//    var wallets = List<DBWallet>()
//}


