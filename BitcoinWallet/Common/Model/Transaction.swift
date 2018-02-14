//
//  Transaction.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 13/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation

enum TransactionType: Int {
    case buy = 0
    case sell
    case exchange
}

enum OperationType: Int {
    case debit = 0
    case credit
}

struct Transaction {
    let identifier: String
    let type: TransactionType
    let operation: OperationType
    let amount: Double
    let date: Date
    let currency: Currency
}

