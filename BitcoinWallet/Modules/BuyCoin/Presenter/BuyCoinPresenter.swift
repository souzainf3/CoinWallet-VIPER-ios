

import Foundation

// presenter ---->> view
protocol BuyCoinPresenterOutput: class {
    func setSelectedCoin(_ coin: Currency)
    func setUnselectedWallet()
    func setSelectedWallet(_ wallet: Wallet)
    
    func showWalletPicker(with wallets: [Wallet])
    func showCoinPicker(with coins: [Currency])
}

// view ---->> presenter
protocol BuyCoinPresenterInput {
    func viewDidLoad()
    func walletSelectionPressed()
    func coinSelectionPressed()
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
        self.output?.setSelectedCoin(self.interactor.coinSelected)
        
        // Wallet to pay
        self.configureWallet()
    }
    
    func walletSelectionPressed() {
        self.output?.showWalletPicker(with: self.interactor.wallets)
    }
    
    func coinSelectionPressed() {
        self.output?.showCoinPicker(with: self.interactor.coinsAvailable)
    }
    
    // MARK: - Private
    
    private func configureWallet() {
        if let wallet = self.interactor.walletSelected {
            self.output?.setSelectedWallet(wallet)
        } else {
            self.output?.setUnselectedWallet()
        }
    }
    
}

// MARK: - WalletInteractorOutput

extension BuyCoinPresenter: BuyCoinInteractorOutput {
}


