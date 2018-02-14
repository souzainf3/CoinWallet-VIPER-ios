//
//  SellCoinWireframe.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 14/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class SellCoinWireframe: StoryboardInstanciate {
    
    let storyboardName = "SellCoin"
    
    private(set) weak var viewController: UIViewController?
    
    
    // MARK: - Public
    
    func presentSellScreen(in navigationController: UINavigationController) {
        
        let viewController = viewControllerFromStoryboard(withIdentifier: "SellCoinViewController") as! SellCoinViewController
        
        let walletDataManager = WalletDataManager(database: DatabaseManager(configuration: .standard))
        let transactionDataManager = TransactionDataManager(database: DatabaseManager(configuration: .standard))
        
        let interactor = SellCoinInteractor(
            walletDataManager: walletDataManager,
            exchangeRateDataManager: ExchangeRateDataManager(),
            transactionDataManager: transactionDataManager
        )
        
        let presenter = SellCoinPresenter(interactor: interactor, wireframe: self)
        presenter.output = viewController
        
        viewController.presenter = presenter
        interactor.output = presenter
        
        navigationController.pushViewController(viewController, animated: true)
        self.viewController = viewController
    }
    
    func dismissSellScreen() {
        self.viewController?.navigationController?.popViewController(animated: true)
    }
    
}
