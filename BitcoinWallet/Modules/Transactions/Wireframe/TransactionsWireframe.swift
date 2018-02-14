//
//  SellCoinWireframe.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 14/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class TransactionsWireframe: TabBarInterface, StoryboardInstanciate {
    
    let storyboardName = "Transactions"
    
    private(set) weak var transactionsViewController: UIViewController?

    
    // MARK: - Public
    
    func configuredViewController() -> UIViewController {
        
        let viewController = newTransactionsViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        defer {
            self.transactionsViewController = viewController
        }
        return navigationController
    }
    
    // MARK: - Private
    
    private func newTransactionsViewController() -> UIViewController {
        
        let viewController = viewControllerFromStoryboard(withIdentifier: "TransactionsViewController") as! TransactionsViewController
        
        let transactionDataManager = TransactionDataManager(database: DatabaseManager(configuration: .standard))
        let interactor = TransactionsInteractor(transactionDataManager: transactionDataManager)

        let presenter = TransactionsPresenter(interactor: interactor, wireframe: self)
        presenter.output = viewController

        viewController.presenter = presenter
        interactor.output = presenter
        
        return viewController
    }
    
}
