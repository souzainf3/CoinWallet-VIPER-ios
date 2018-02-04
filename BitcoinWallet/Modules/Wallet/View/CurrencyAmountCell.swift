//
//  CurrencyAmountCell.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit
import Letters

class CurrencyAmountCell: UITableViewCell {
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

extension CurrencyAmountCell {
    func configure(with item: WalletItem) {
        self.titleLabel.text = item.title
        self.amountLabel.text = item.amountValue
        self.currencyImageView.setImage(string: item.icon.symbol, color: item.icon.color, circular: true)
    }
}


