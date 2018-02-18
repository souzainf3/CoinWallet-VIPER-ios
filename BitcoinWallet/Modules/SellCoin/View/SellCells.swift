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
    
    func setEmpty(title: String) {
        self.currencyLabel.backgroundColor = .lightGray
        self.currencyLabel.text = nil
        self.titleLabel.text = title
    }
    
    func configure(with currency: Currency) {
        self.currencyLabel.backgroundColor = currency.color
        self.currencyLabel.text = currency.abbreviation
        self.titleLabel.text = currency.name
    }
}


// TODO: - Refactor cell's to reusable or use Protocol to conformance same code
// MARK: - WalletDebitCell

class WalletDetailCell: UITableViewCell {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

extension WalletDetailCell {
    
    func setEmpty(title: String) {
        return configure(
            currencyColor: .lightGray,
            currencyAbbreviation: nil,
            title: title,
            balanceTitle: nil,
            amountValue: nil
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
