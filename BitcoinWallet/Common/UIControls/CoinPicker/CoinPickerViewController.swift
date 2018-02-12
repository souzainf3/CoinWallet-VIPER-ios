//
//  CoinPickerViewController.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

struct CoinPickerDisplayItem {
    let title: String
    let amountValue: String
    let currencyFlag: (abbreviation: String, color: UIColor)
}

extension CoinPickerViewController {
        
    func present(in viewController: UIViewController) {
        
        let width = viewController.view.frame.width
        self.preferredContentSize = CGSize(width: width, height: 350)
        
        let navigation = UINavigationController(rootViewController: self)
        navigation.modalPresentationStyle = .custom
        navigation.transitioningDelegate = self.transitionDelegate
        
        viewController.present(navigation, animated: true, completion: nil)
    }
}

class CoinPickerViewController<T>: UITableViewController {
    
    private var items: [T] = []
    private var didSelectedItem: (T) -> Void
    private var cellLayoutAdapter: (T) -> CoinPickerDisplayItem
    
    private lazy var transitionDelegate = SheetTransitioningDelegate(modalDisplayStyle: .actionSheet)

    
    // MARK: - Initializers
    
    init(title: String?, items: [T], didSelectedItem: @escaping (T) -> Void, cellLayoutAdapter: @escaping (T) -> CoinPickerDisplayItem) {
        self.items = items
        self.cellLayoutAdapter = cellLayoutAdapter
        self.didSelectedItem = didSelectedItem
        
        super.init(style: .grouped)
        self.title = title
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 55
        self.tableView.register(UINib(nibName: "CoinPickerCell", bundle: nil), forCellReuseIdentifier: CoinPickerCell.reuseIdentifier)
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoinPickerCell.reuseIdentifier, for: indexPath) as! CoinPickerCell

        let item = self.items[indexPath.row]
        cell.configure(with: self.cellLayoutAdapter(item))
        
        if indexPath.row == 0  {
            cell.accessoryType = .checkmark
        } else {
            // AccessoryType space reserved
            cell.accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 23, height: 23))
        }

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let item = self.items[indexPath.row]
        self.didSelectedItem(item)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}



