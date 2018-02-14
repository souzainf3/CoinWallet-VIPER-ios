//
//  SellCoinViewController.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 14/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class SellCoinViewController: UITableViewController {

    @IBOutlet private weak var coinAmountView: SellCoinAmountCell!
    @IBOutlet private weak var walletDebitView: WalletDetailCell!
    @IBOutlet private weak var walletCreditView: CurrencyCell!


    var presenter: SellCoinPresenterInput?

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Vender"
        self.presenter?.viewDidLoad()
    }

    
    // MARK: - Targets/Actions
    
    @IBAction func sellPressed(_ sender: Any) {
        self.presenter?.didPressedSell(amount: self.coinAmountView.amountTextField.currencyValue)
    }
    
    
    // MARK: - Table view dfmounturce
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { // Debit Wallet
            self.presenter?.pressedWalletSelection()
        } else if indexPath.section == 2 { // Credit Currency
            self.presenter?.pressedCurrencySelection()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SellCoinPresenterOutput

extension SellCoinViewController: SellCoinPresenterOutput {
    func showLoading() {
        self.view.endEditing(true)
        self.navigationController?.view.rn_activityView.dimBackground = true
        self.navigationController?.view.showActivityView()
    }
    
    func hideLoading() {
        self.navigationController?.view.hideActivityView()
    }
    
    func configureOutputCurrency(_ currency: Currency) {
        self.coinAmountView.configure(with: currency)
    }
    
    func configureDebitWallet(_ wallet: Wallet) {
        self.walletDebitView.configure(with: wallet)
    }
    
    func configureEmptyDebitWallet(message: String) {
        self.walletDebitView.setEmpty(title: message)
    }
    
    func configureEmptyCreditCurrency(message: String) {
    }
    
    func showWalletPicker(title: String, wallets: [Wallet], walletSelected: Wallet?) {
        let pickerController = CoinPickerViewController<Wallet>(title: title, items: wallets, itemSelected: walletSelected, didSelectedItem: { wallet in
            self.presenter?.didSelected(wallet: wallet)
        }, cellLayoutAdapter: { wallet -> CoinPickerDisplayItem in
            return CoinPickerDisplayItem(
                title: wallet.currency.name,
                amountValue: wallet.amountFormatted,
                currencyFlag: (abbreviation: wallet.currency.abbreviation, color: wallet.currency.color)
            )
        })
        
        pickerController.present(in: self)
    }
    
    func showCoinPicker(title: String, currencies: [Currency], currencySelected: Currency?) {
        let pickerController = CoinPickerViewController<Currency>(title: title, items: currencies, itemSelected: currencySelected, didSelectedItem: { currency in
            self.presenter?.didSelected(currency: currency)
        }, cellLayoutAdapter: { currency -> CoinPickerDisplayItem in
            return CoinPickerDisplayItem(
                title: currency.name,
                amountValue: "",
                currencyFlag: (abbreviation: currency.abbreviation, color: currency.color)
            )
        })
        pickerController.present(in: self)
    }
    
    func showAlert(title: String, message: String, buttonTitle: String, onDismiss: (() -> Void)?) {
        UIAlertController.show(title: title, message: message, cancelButtonTitle: buttonTitle, cancelBlock: onDismiss)
    }
    
    
}



