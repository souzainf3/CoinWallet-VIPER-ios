//
//  WalletCell.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class WalletCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

extension WalletCell {
    func configure(with item: WalletItem) {
        self.titleLabel.text = item.title
        self.amountLabel.text = item.amountValue
        self.symbolLabel.text = item.tag.currency
        self.symbolLabel.backgroundColor = item.tag.color
    }
}


