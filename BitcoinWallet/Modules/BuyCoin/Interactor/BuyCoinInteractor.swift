
import UIKit

// presenter ---->> interactor
protocol BuyCoinInteractorInput {
    var selectedCoin: Currency { get set}
    var selectedWallet: Wallet? { get set}

}

// interactor ---->> presenter
protocol BuyCoinInteractorOutput: class {
}

class BuyCoinInteractor: BuyCoinInteractorInput {

    weak var output: BuyCoinInteractorOutput?
    
    let dataManager: BuyCoinDataManagerInput
    
    // Default Coin selected
    var selectedCoin: Currency = .bitcoin
    
    // Wallet to pay coins
    var selectedWallet: Wallet?
    
    init(dataManager: BuyCoinDataManagerInput) {
        self.dataManager = dataManager
    }
    
    
    // MARK: Input
    
}

