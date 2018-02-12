

import Foundation

// presenter ---->> view
protocol BuyCoinPresenterOutput: class {
    func configureSelectedCoin(_ coin: Currency)
    func configureWalletNotSelected()
    func configureSelectedWallet(_ wallet: Wallet)
    
    func showWalletPicker(title: String, wallets: [Wallet], walletSelected: Wallet?)
    func showCoinPicker(title: String, coins: [Currency], coinSelected: Currency?)
}

// view ---->> presenter
protocol BuyCoinPresenterInput {
    func viewDidLoad()
    func walletSelectionPressed()
    func coinSelectionPressed()
    func didSelected(coin: Currency)
    func didSelected(wallet: Wallet)
}

class BuyCoinPresenter: BuyCoinPresenterInput {
    
    weak var output: BuyCoinPresenterOutput?
    weak var wireframe: BuyCoinWireframe?
    var interactor: BuyCoinInteractorInput

    
    // MARK: Initializes
    
    init(interactor: BuyCoinInteractorInput, wireframe: BuyCoinWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    
    // MARK: Input
    
    func viewDidLoad() {
        // Coin to buy
        self.configureCoin()
        
        // Wallet to pay
        self.configureWallet()
    }
    
    func walletSelectionPressed() {
        self.output?.showWalletPicker(
            title: "Selecione uma carteira",
            wallets: self.interactor.wallets,
            walletSelected: self.interactor.walletSelected
        )
    }
    
    func coinSelectionPressed() {
        self.output?.showCoinPicker(
            title: "Selecione uma moeda",
            coins: self.interactor.coinsAvailable,
            coinSelected: self.interactor.coinSelected
        )
    }
    
    func didSelected(coin: Currency) {
        self.interactor.coinSelected = coin
        self.configureCoin()
    }
    
    func didSelected(wallet: Wallet) {
        self.interactor.walletSelected = wallet
        self.configureWallet()
    }

    
    // MARK: - Private
    
    private func configureCoin() {
        self.output?.configureSelectedCoin(self.interactor.coinSelected)
    }
    
    private func configureWallet() {
        if let wallet = self.interactor.walletSelected {
            self.output?.configureSelectedWallet(wallet)
        } else {
            self.output?.configureWalletNotSelected()
        }
    }
    
}

// MARK: - WalletInteractorOutput

extension BuyCoinPresenter: BuyCoinInteractorOutput {
}


