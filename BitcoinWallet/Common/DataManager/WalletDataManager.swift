//
//
//  Created by Romilson Nunes on 26/02/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation

protocol WalletDataManagerInput: class {
    func observeWalletUpdates(_ block: BlockCompletion?)
    // Fech
    func fetchUserWallets() -> [Wallet]
    func fetchUserWallet(from currency: Currency) -> Wallet
    // Increment
    func increment(amount: Double, to wallet: Wallet)
    func incrementWallet(amount: Double, currency: Currency)
    // Decrement
    func decrementWallet(amount: Double, currency: Currency)
    func decrement(amount: Double, from wallet: Wallet)
}

class WalletDataManager {
   
    private(set) var database: StorageContext

    init(database: StorageContext) {
        self.database = database
    }
}


// MARK: - WalletDataManagerInput

extension WalletDataManager: WalletDataManagerInput {
    
    func observeWalletUpdates(_ block: BlockCompletion?) {
        self.database.storageContextNotification = block
    }
    
    func fetchUserWallets() -> [Wallet] {
        return Currency.all.map({ self.fetchUserWallet(from: $0) })
    }
    
    func fetchUserWallet(from currency: Currency) -> Wallet {
        let filter = NSPredicate(format: "currency = '\(currency.identifier)'")
        if let wallet = self.database.fetch(DBWallet.self, predicate: filter, sorted: nil).flatMap({
            Wallet(currency: currency, amount: $0.amount)
        }).first {
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
    
    private func updateWallet(_ wallet: Wallet) {
        let dbWallet = DBWallet()
        dbWallet.currency = wallet.currency.abbreviation
        dbWallet.amount = wallet.amount

        do {
         try self.database.salve(object: dbWallet, update: true)
        } catch {
            print(error)
        }
    }
    
}


