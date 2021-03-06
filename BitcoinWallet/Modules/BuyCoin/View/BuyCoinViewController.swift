
//  WalletViewController.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit
import RNActivityView

class BuyCoinViewController: UITableViewController {

    @IBOutlet private weak var coinView: BuyCoinAmountCell!
    @IBOutlet private weak var walletView: WalletToPayCell!

    var presenter: BuyCoinPresenterInput?
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Comprar"
        self.presenter?.viewDidLoad()
    }

    
    // MARK: - Targets/Actions

    @IBAction func selecteCoinsPressed(_ sender: Any) {
        self.presenter?.coinSelectionPressed()
    }
    
    @IBAction func buyPressed(_ sender: Any) {
        self.presenter?.didPressedBuy(amount: coinView.amountTextField.currencyValue)
    }

    
    // MARK: - Table view dfmounturce

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - Melhorar lógica de validação
        if indexPath.section == 1 {
            self.presenter?.walletSelectionPressed()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }

}


// MARK: - BuyCoinPresenterOutput

extension BuyCoinViewController: BuyCoinPresenterOutput {
   
    func showLoading() {
        self.view.endEditing(true)
        self.navigationController?.view.rn_activityView.dimBackground = true
        self.navigationController?.view.showActivityView()
    }
    
    func hideLoading() {
        self.navigationController?.view.hideActivityView()
    }
    
    func configureSelectedCoin(_ coin: Currency) {
        self.coinView.configure(with: coin)
    }
    
    func configureWalletNotSelected(message: String) {
        self.walletView.setEmpty(title: message)
    }
    
    func configureSelectedWallet(_ wallet: Wallet) {
        self.walletView.configure(with: wallet)
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
    
    func showCoinPicker(title: String, coins: [Currency], coinSelected: Currency?) {
        let pickerController = CoinPickerViewController<Currency>(title: title, items: coins, itemSelected: coinSelected, didSelectedItem: { coin in
            self.presenter?.didSelected(coin: coin)
        }, cellLayoutAdapter: { coin -> CoinPickerDisplayItem in
            return CoinPickerDisplayItem(
                title: coin.name,
                amountValue: "",
                currencyFlag: (abbreviation: coin.abbreviation, color: coin.color)
            )
        })
        pickerController.present(in: self)
    }
    
    func showAlert(title: String, message: String, buttonTitle: String, onDismiss: (() -> Void)?) {
        UIAlertController.show(title: title, message: message, cancelButtonTitle: buttonTitle, cancelBlock: onDismiss)
    }
}


