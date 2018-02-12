
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
    
    let walletDataManager: WalletDataManagerInput
    let exchangeRateDataManager: ExchangeRateDataManagerInput
    

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
        return self.walletDataManager.fetchUserWallet().filter({ $0.currency != self.coinSelected })
    }
    
    // Only virtual currencies
    var coinsAvailable: [Currency] {
        return Currency.all.filter({ $0.isVirtual })
    }
    
    
    // MARK: - Initializer
    
    init(walletDataManager: WalletDataManagerInput, exchangeRateDataManager: ExchangeRateDataManagerInput) {
        self.walletDataManager = walletDataManager
        self.exchangeRateDataManager = exchangeRateDataManager
    }
    
    
    // MARK: - Private
    
    private func coinValueChanged() {
        self.output?.configureSelectedCoin(self.coinSelected)
        self.walletSelected = nil // Clean Wallet selection
    }
    
    private func walletValueChanged() {
        if let wallet = self.walletSelected {
            self.output?.configureSelectedWallet(wallet)
            
            let amount: Double = 1
            print("From: \(self.coinSelected.abbreviation) - Amount: \(amount)")

            do {
                let value = try self.exchangeRateDataManager.converter(amount: amount, from: self.coinSelected, to: wallet.currency)
                print("To: \(wallet.currency.abbreviation) - Amount: \(value)")
            } catch let error {
                print(error)
            }

            
        } else {
            self.output?.configureUnselectedWallet()
        }
    }
}

