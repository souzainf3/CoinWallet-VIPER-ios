
import UIKit

// presenter ---->> interactor
protocol WalletInteractorInput {
    func getUserWallet() -> [Wallet]
}

// interactor ---->> presenter
protocol WalletInteractorOutput: class {
}

class WalletInteractor: WalletInteractorInput {

    weak var output: WalletInteractorOutput?
    
    let dataManager: WalletDataManagerInput
    
    init(dataManager: WalletDataManagerInput) {
        self.dataManager = dataManager
    }
    
    
    // MARK: Input
    
    func getUserWallet() -> [Wallet] {
        return self.dataManager.fetchUserWallet()
    }
    
}

