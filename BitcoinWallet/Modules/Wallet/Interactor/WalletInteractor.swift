
import UIKit

// presenter ---->> interactor
protocol WalletInteractorInput {
    func fetchUserWallets() -> [Wallet]
}

// interactor ---->> presenter
protocol WalletInteractorOutput: class {
    func didUpdateUserWallets(_ wallets: [Wallet])
}

class WalletInteractor: WalletInteractorInput {

    weak var output: WalletInteractorOutput?
    
    let dataManager: WalletDataManagerInput
    
    init(dataManager: WalletDataManagerInput) {
        self.dataManager = dataManager
        self.dataManager.observeWalletUpdates {
            self.output?.didUpdateUserWallets(self.fetchUserWallets())
        }
    }
    
    
    // MARK: Input
    
    func fetchUserWallets() -> [Wallet] {
        return self.dataManager.fetchUserWallets()
    }
    
}

