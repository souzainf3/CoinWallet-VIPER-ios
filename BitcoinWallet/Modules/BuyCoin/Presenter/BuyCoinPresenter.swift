

import Foundation


// presenter ---->> view
protocol BuyCoinPresenterOutput: class {
    func setSelectedCoin(_ coin: Currency)
    
    func showUnselectedWallet()
    func showSelectedWallet(_ wallet: Wallet)
}

// view ---->> presenter
protocol BuyCoinPresenterInput {
    func viewDidLoad()
}

class BuyCoinPresenter: BuyCoinPresenterInput {
    
    weak var output: BuyCoinPresenterOutput?
    weak var wireframe: BuyCoinWireframe?
    let interactor: BuyCoinInteractorInput

    
    // MARK: Initializes
    
    init(interactor: BuyCoinInteractorInput, wireframe: BuyCoinWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    
    // MARK: Input
    
    func viewDidLoad() {
        // Coin to buy
        self.output?.setSelectedCoin(self.interactor.selectedCoin)
        
        // Wallet to pay
        if let wallet = self.interactor.selectedWallet {
            self.output?.showSelectedWallet(wallet)
        } else {
            self.output?.showUnselectedWallet()
        }
    }
    
    
    // MARK: - Private
    
}

// MARK: - WalletInteractorOutput

extension BuyCoinPresenter: BuyCoinInteractorOutput {
}


