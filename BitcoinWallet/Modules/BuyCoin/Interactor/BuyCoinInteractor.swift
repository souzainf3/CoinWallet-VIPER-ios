
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
}

class BuyCoinInteractor: BuyCoinInteractorInput {
    
    weak var output: BuyCoinInteractorOutput?
    
    let dataManager: WalletDataManagerInput
    
    // Coin selected. Default value is .bitcoin
    var coinSelected: Currency = .bitcoin
    
    // Wallet to pay coins
    var walletSelected: Wallet?
    
    // User Wallets
    var wallets: [Wallet] {
        return self.dataManager.fetchUserWallet()
    }
    
    // Only virtual currencies
    var coinsAvailable: [Currency] {
        return Currency.all.filter({ $0.isVirtual })
    }
    
    init(dataManager: WalletDataManagerInput) {
        self.dataManager = dataManager
    }
    
    // MARK: Input
    
}

