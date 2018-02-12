//
//  BuyCoinAmountCell.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 04/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit


// MARK: - BuyCoinAmountCell

class BuyCoinAmountCell: UITableViewCell {
    @IBOutlet weak var amountTextField: CurrencyTextField!
    @IBOutlet weak var coinButton: UIButton!
}

extension BuyCoinAmountCell {
    func configure(with coin: Currency) {
        coinButton.backgroundColor = coin.color
        coinButton.setTitle(coin.abbreviation, for: .normal)
        amountTextField.currencySymbol = coin.symbol
    }
}

// MARK: - BuyCoinAmountCell

class WalletToPayCell: UITableViewCell {
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

extension WalletToPayCell {
    
    func setEmpty() {
        return configure(
            currencyColor: .clear,
            currencyAbbreviation: nil,
            currencyTitle: nil,
            balanceTitle: nil,
            amountValue: "Selecione uma carteira"
        )
    }
    
    func configure(with wallet: Wallet) {
        configure(
            currencyColor: wallet.currency.color,
            currencyAbbreviation: wallet.currency.abbreviation,
            currencyTitle: wallet.currency.name,
            balanceTitle: "SALDO",
            amountValue: wallet.amountFormatted
        )
    }
    
    func configure(currencyColor: UIColor?, currencyAbbreviation: String?, currencyTitle: String?, balanceTitle: String?, amountValue: String?) {
        currencyLabel.backgroundColor = currencyColor
        currencyLabel.text = currencyAbbreviation
        titleLabel.text = currencyTitle
        balanceLabel.text = balanceTitle
        amountLabel.text = amountValue
    }
}





