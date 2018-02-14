//
//  Transaction.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 13/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

enum TransactionType: Int {
    case buy = 0
    case sell
    case exchange
}

enum OperationType: Int {
    case debit = 0
    case credit
    
    var color: UIColor {
        switch self {
        case .credit:
            return UIColor(red: 40/255, green: 225/255, blue: 40/255, alpha: 1)
        case .debit:
            return UIColor(red: 225/255, green: 40/255, blue: 40/255, alpha: 1)
        }
    }
}

struct Transaction {
    let identifier: String
    let type: TransactionType
    let operation: OperationType
    let amount: Double
    let date: Date
    let currency: Currency
}

