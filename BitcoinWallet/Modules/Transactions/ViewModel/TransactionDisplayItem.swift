//
//  TransactionDisplayItem.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 14/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

struct TransactionDisplayItem {
    let title: String
    let titleColor: UIColor
    let description: String
    let date: String
    let currency: (name: String, abbreviation: String, color: UIColor)
}
