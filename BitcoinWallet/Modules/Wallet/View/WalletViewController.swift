//
//  WalletViewController.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class WalletViewController: UITableViewController {

    var presenter: WalletPresenterInput?
    
    private var viewModel: WalletViewModel = WalletViewModel(title: "", items: []) {
        didSet {
            self.tableView.reloadData()
        }
    }

    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Carteira"
        self.presenter?.viewDidLoad()
    }

    
    // MARK: - Targets/Actions
    
    @IBAction func pressedBuyButton() {
        self.presenter?.didPressedBuyButton()
    }
    
    @IBAction func pressedSellButton() {
        self.presenter?.didPressedSellButton()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.title
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyAmountCell.reuseIdentifier, for: indexPath) as! CurrencyAmountCell

        let item = self.viewModel.items[indexPath.row]
        cell.configure(with: item)

        return cell
    }

}


// MARK: - WalletPresenterOutput

extension WalletViewController: WalletPresenterOutput {
    func reloadWallet(viewModel: WalletViewModel) {
        self.viewModel = viewModel
    }
}


