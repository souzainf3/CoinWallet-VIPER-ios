//
//  WalletViewController.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class BuyCoinViewController: UITableViewController {

    var presenter: BuyCoinPresenterInput?
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Comprar"
        self.presenter?.viewDidLoad()
    }

    
    // MARK: - Targets/Actions


    // MARK: - Table view data source

//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return self.viewModel.title
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.viewModel.items.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyAmountCell.reuseIdentifier, for: indexPath) as! CurrencyAmountCell
//
//        let item = self.viewModel.items[indexPath.row]
//        cell.configure(with: item)
//
//        return cell
//    }

}


// MARK: - BuyCoinPresenterOutput

extension BuyCoinViewController: BuyCoinPresenterOutput {
}


