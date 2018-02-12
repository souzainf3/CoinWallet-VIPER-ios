
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


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
    
    func showWalletPicker(with wallets: [Wallet]) {
        // TODO: - Show picker
    }
    
    func showCoinPicker(with coins: [Currency]) {
        // TODO: - Show picker
    }
}


