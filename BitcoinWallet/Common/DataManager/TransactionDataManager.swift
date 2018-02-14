//
//  TransactionDataManager.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 13/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation

protocol TransactionDataManagerInput: class {
    func transactions(ascending: Bool) -> [Transaction]
    func setNewTransaction(type: TransactionType, operation: OperationType, amount: Double, currency: Currency)
}

class TransactionDataManager {
    let database: StorageContext
    
    init(database: StorageContext) {
        self.database = database
    }
}

extension TransactionDataManager: TransactionDataManagerInput {
    
    func transactions(ascending: Bool = true) -> [Transaction] {
        let sort = Sorted(key: "date", ascending: ascending)
        let transactions = self.database.fetch(DBTransaction.self, predicate: nil, sorted: sort)

        return transactions.flatMap({
            guard let currency = Currency(identifier: $0.currency) else {
                return nil
            }
            guard let type = TransactionType(rawValue: $0.type) else {
                return nil
            }
            guard let operation  = OperationType(rawValue: $0.operation) else {
                return nil
            }
            return Transaction(identifier: $0.identifier, type: type, operation: operation, amount: $0.amount, date: $0.date, currency: currency)
        })
    }
    
    func setNewTransaction(type: TransactionType, operation: OperationType, amount: Double, currency: Currency) {
        let date = Date()
        let identifier = date.toString(format: "yyyyMMddHHmmssSSS") ?? UUID().uuidString
        let dbTransaction = DBTransaction(
            identifier: identifier,
            type: type.rawValue,
            operation: operation.rawValue,
            amount: amount,
            date: date,
            currency:
            currency.identifier
        )
        
        do {
            try self.database.salve(object: dbTransaction, update: false)
        } catch {
            print(error)
        }
    }
    
}
