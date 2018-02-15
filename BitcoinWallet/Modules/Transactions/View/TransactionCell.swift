//
//  TransactionCell.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 14/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class TransactionCell: UITableViewCell {
    @IBOutlet weak var flagCurrencyLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
}

extension TransactionCell {
    
    func configure(with item: TransactionDisplayItem) {
        self.dateLabel.text = item.date
        self.titleLabel.text = item.title
        self.descriptionLabel.text = item.description
        self.currencyNameLabel.text = item.currency.name
        self.flagCurrencyLabel.text = item.currency.abbreviation
        self.flagCurrencyLabel.backgroundColor = item.currency.color
        self.titleLabel.textColor = item.titleColor
    }
}
