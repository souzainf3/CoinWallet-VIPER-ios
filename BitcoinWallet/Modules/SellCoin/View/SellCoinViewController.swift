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


    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    // MARK: - Targets/Actions
    
    @IBAction func sellPressed(_ sender: Any) {
    }
    
    
    // MARK: - Table view dfmounturce
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 { // Debit Wallet
        } else if indexPath.section == 2 { // Credit Wallet
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}



