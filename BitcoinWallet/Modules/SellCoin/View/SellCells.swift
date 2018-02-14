//
//  SellCells.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 14/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit


// MARK: - SellCoinAmountCell

class SellCoinAmountCell: UITableViewCell {
    @IBOutlet weak var amountTextField: CurrencyTextField!
}

extension SellCoinAmountCell {
    func configure(with coin: Currency) {
        amountTextField.currencySymbol = coin.symbol
    }
}


// MARK: - WalletDebitCell

class CurrencyCell: UITableViewCell {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
}


// TODO: - Refactor cell's to reusable or use Protocol to conformance same code
// MARK: - WalletDebitCell

class WalletDetailCell: UITableViewCell {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

// TODO: - Refactor code repeated
extension WalletDetailCell {
    
    func setEmpty(title: String) {
        return configure(
            currencyColor: .clear,
            currencyAbbreviation: nil,
            title: nil,
            balanceTitle: nil,
            amountValue: title
        )
    }
    
    func configure(with wallet: Wallet) {
        configure(
            currencyColor: wallet.currency.color,
            currencyAbbreviation: wallet.currency.abbreviation,
            title: wallet.currency.name,
            balanceTitle: "SALDO", // TODO: - localize string
            amountValue: wallet.amountFormatted
        )
    }
    
    func configure(currencyColor: UIColor?, currencyAbbreviation: String?, title: String?, balanceTitle: String?, amountValue: String?) {
        currencyLabel.backgroundColor = currencyColor
        currencyLabel.text = currencyAbbreviation
        titleLabel.text = title
        balanceLabel.text = balanceTitle
        amountLabel.text = amountValue
    }
}
