//
//  TransactionsViewController.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 14/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class TransactionsViewController: UITableViewController {

    var presenter: TransactionsPresenterInput?

    private var items: [TransactionDisplayItem] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Histórico"
        self.presenter?.viewDidLoad()
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.reuseIdentifier, for: indexPath) as! TransactionCell

        // TODO: - Config in cell
        let item = self.items[indexPath.row]
        cell.dateLabel.text = item.date
        cell.titleLabel.text = item.title
        cell.descriptionLabel.text = item.description
        cell.currencyNameLabel.text = item.currency.name
        cell.flagCurrencyLabel.text = item.currency.abbreviation
        cell.flagCurrencyLabel.backgroundColor = item.currency.color
        cell.titleLabel.textColor = item.titleColor
        
        return cell
    }
 
}


// MARK: - TransactionsPresenterOutput

extension TransactionsViewController: TransactionsPresenterOutput {
    func showTransactionItems(items: [TransactionDisplayItem]) {
        self.items = items
    }
    
}



