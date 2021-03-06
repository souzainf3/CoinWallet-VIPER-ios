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

        cell.configure(with: self.items[indexPath.row])
        
        return cell
    }
 
}


// MARK: - TransactionsPresenterOutput

extension TransactionsViewController: TransactionsPresenterOutput {
    func showTransactionItems(items: [TransactionDisplayItem]) {
        self.items = items
    }
    
}



