//
//
//  Created by Romilson Nunes on 26/02/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation

protocol WalletDataManagerInput: class {
    func fetchUserWallets() -> [Wallet]
    func fetchUserWallet(from currency: Currency) -> Wallet

    func increment(amount: Double, to wallet: Wallet)
    func decrement(amount: Double, from wallet: Wallet)
    
    func incrementWallet(amount: Double, currency: Currency)
    func decrementWallet(amount: Double, currency: Currency)
}

class WalletDataManager {
   
    // TODO: - Remover singleton
    static let shared: WalletDataManager = WalletDataManager(database: DatabaseManager())
    
    let database: StorageContext

    // TODO: - Remover MOCK
//    private var wallets: Set = [
//        Wallet(currency: .real, amount: 100000.0),
//        Wallet(currency: .bitcoin, amount: 0.002),
//        Wallet(currency: .britta, amount: 0.0)
//    ]
    
    init(database: StorageContext) {
        self.database = database
    }
}

extension WalletDataManager: WalletDataManagerInput {
    
    func fetchUserWallets() -> [Wallet] {
        return Currency.all.map({ self.fetchUserWallet(from: $0) })
    }
    
    func fetchUserWallet(from currency: Currency) -> Wallet {
        let filter = NSPredicate(format: "currency = '\(currency.abbreviation)'")
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
    
    func updateWallet(_ wallet: Wallet) {
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


