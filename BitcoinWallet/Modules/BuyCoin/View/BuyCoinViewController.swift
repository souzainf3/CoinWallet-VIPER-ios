
//  WalletViewController.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

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
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // TODO: - Melhorar lógica de validação
        if indexPath.section == 1 {
            self.presenter?.walletSelectionPressed()
        }
    }

}


// MARK: - BuyCoinPresenterOutput

extension BuyCoinViewController: BuyCoinPresenterOutput {

    func setSelectedCoin(_ coin: Currency) {
        self.coinView.configure(with: coin)
    }
    
    func setUnselectedWallet() {
        self.walletView.setEmpty()
    }
    
    func setSelectedWallet(_ wallet: Wallet) {
        self.walletView.configure(with: wallet)
    }
    
    func showWalletPicker(title: String, wallets: [Wallet]) {
        let pickerController = CoinPickerViewController<Wallet>(title: title, items: wallets, didSelectedItem: { wallet in
            
        }) { wallet -> CoinPickerDisplayItem in
            return CoinPickerDisplayItem(
                title: wallet.currency.name,
                amountValue: wallet.amountFormatted,
                currencyFlag: (abbreviation: wallet.currency.abbreviation, color: wallet.currency.color)
            )
        }
        
        pickerController.present(in: self)
    }
    
    func showCoinPicker(title: String, coins: [Currency]) {
        let pickerController = CoinPickerViewController<Currency>(title: title, items: coins, didSelectedItem: { coin in
            
        }, cellLayoutAdapter: { coin -> CoinPickerDisplayItem in
            return CoinPickerDisplayItem(
                title: coin.name,
                amountValue: "",
                currencyFlag: (abbreviation: coin.abbreviation, color: coin.color)
            )
        })
        pickerController.present(in: self)
    }
}


