//
//
//  Created by Romilson Nunes on 26/02/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation

// TODO: - Agrupar Data Managers em uma única camada (pasta)
protocol WalletDataManagerInput: class {
    func fetchUserWallets() -> [Wallet]
    func fetchUserWallet(from currency: Currency) -> Wallet

    func increment(amount: Double, to wallet: Wallet)
    func decrement(amount: Double, from wallet: Wallet)
    
    func incrementWallet(amount: Double, currency: Currency)
    func decrementWallet(amount: Double, currency: Currency)
}

class WalletDataManager {
   
    static let shared: WalletDataManager = WalletDataManager()

    // TODO: - Remover MOCK
    private var wallets: Set = [
        Wallet(currency: .real, amount: 100000.0),
        Wallet(currency: .bitcoin, amount: 0.002),
        Wallet(currency: .britta, amount: 0.0)
    ]
    
    private init() {
    }
}

extension WalletDataManager: WalletDataManagerInput {
    
    func fetchUserWallets() -> [Wallet] {
        // TODO: - Remove Mock
        return Array(self.wallets)
    }
    
    func fetchUserWallet(from currency: Currency) -> Wallet {
        if let wallet = self.fetchUserWallets().first(where: { $0.currency == currency }) {
            return wallet
        }
        
        // Create a new empty wallet
        return Wallet(currency: currency, amount: 0.0)
    }
    
    func incrementWallet(amount: Double, currency: Currency) {
        self.increment(amount: amount, to: self.fetchUserWallet(from: currency))
    }
    
    func decrementWallet(amount: Double, currency: Currency) {
        self.decrement(amount: amount, from: self.fetchUserWallet(from: currency))
    }
    
    func increment(amount: Double, to wallet: Wallet) {
        var wallet = wallet
        wallet.increment(value: amount)
        self.updateWallet(wallet)
    }
    
    func decrement(amount: Double, from wallet: Wallet) {
        var wallet = wallet
        wallet.decrement(value: amount)
        self.updateWallet(wallet)
    }
    
    
    // MARK: - Private
    
    func updateWallet(_ wallet: Wallet) {
        self.wallets.update(with: wallet)
    }
    
}


