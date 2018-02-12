
import UIKit

// presenter ---->> interactor
protocol BuyCoinInteractorInput {
    var coinSelected: Currency { get set}
    var walletSelected: Wallet? { get set}
    
    var wallets: [Wallet] { get }
    var coinsAvailable: [Currency] { get }


}

// interactor ---->> presenter
protocol BuyCoinInteractorOutput: class {
    func configureSelectedCoin(_ coin: Currency)
    func configureSelectedWallet(_ wallet: Wallet)
    func configureUnselectedWallet()
}

class BuyCoinInteractor: BuyCoinInteractorInput {
    
    weak var output: BuyCoinInteractorOutput?
    
    let dataManager: WalletDataManagerInput
    

    // MARK: - Input

    // Coin selected. Default value is .bitcoin
    var coinSelected: Currency = .bitcoin {
        didSet {
            self.coinValueChanged()
        }
    }
    
    // Wallet to pay coins
    var walletSelected: Wallet? {
        didSet {
           self.walletValueChanged()
        }
    }
    
    // User Wallets
    var wallets: [Wallet] {
        return self.dataManager.fetchUserWallet().filter({ $0.currency != self.coinSelected })
    }
    
    // Only virtual currencies
    var coinsAvailable: [Currency] {
        return Currency.all.filter({ $0.isVirtual })
    }
    
    
    // MARK: - Initializer
    
    init(dataManager: WalletDataManagerInput) {
        self.dataManager = dataManager
    }
    
    
    // MARK: - Private
    
    private func coinValueChanged() {
        self.output?.configureSelectedCoin(self.coinSelected)
        self.walletSelected = nil // Clean Wallet selection
    }
    
    private func walletValueChanged() {
        if let wallet = self.walletSelected {
            self.output?.configureSelectedWallet(wallet)
        } else {
            self.output?.configureUnselectedWallet()
        }
    }
}

