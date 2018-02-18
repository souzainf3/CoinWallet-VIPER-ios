
import UIKit

// presenter ---->> interactor
protocol BuyCoinInteractorInput {
    var coinSelected: Currency { get set}
    var walletSelected: Wallet? { get set}
    var wallets: [Wallet] { get }
    var coinsAvailable: [Currency] { get }

    func buy(amount: Double)
}

// interactor ---->> presenter
protocol BuyCoinInteractorOutput: class {
    func configureSelectedCoin(_ coin: Currency)
    func configureSelectedWallet(_ wallet: Wallet)
    func configureUnselectedWallet()
    func buyed()
    func buyFailed(with error: BuyCoinFail)
}

enum BuyCoinFail: Error {
    case walletNotSelected
    case invalidValue
    case exchangeRateUnavailable
    case insufficientBalance
}

class BuyCoinInteractor: BuyCoinInteractorInput {
    
    weak var output: BuyCoinInteractorOutput?
    
    let walletDataManager: WalletDataManagerInput
    let exchangeRateDataManager: ExchangeRateDataManagerInput
    let transactionDataManager: TransactionDataManagerInput

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
        return self.walletDataManager.fetchUserWallets().filter({ $0.currency != self.coinSelected })
    }
    
    // Only virtual currencies
    var coinsAvailable: [Currency] {
        return Currency.all.filter({ $0.isVirtual })
    }
    
    
    // MARK: - Initializer
    
    init(walletDataManager: WalletDataManagerInput, exchangeRateDataManager: ExchangeRateDataManagerInput, transactionDataManager: TransactionDataManagerInput) {
        self.walletDataManager = walletDataManager
        self.exchangeRateDataManager = exchangeRateDataManager
        self.transactionDataManager = transactionDataManager
    }
    
    
    // MARK: - Input

    func buy(amount: Double) {
        guard let wallet = self.walletSelected else {
            self.output?.buyFailed(with: .walletNotSelected)
            return
        }
        
        guard amount > 0 else {
            self.output?.buyFailed(with: .invalidValue)
            return
        }

        self.tryBuy(amount: amount, in: wallet)
    }
    
    
    // MARK: - Private
    
    private func tryBuy(amount: Double, in wallet: Wallet) {
        do {
            let valueConverted = try self.exchangeRateDataManager.convert(amount: amount, from: self.coinSelected, to: wallet.currency)
            
            print("From: \(self.coinSelected.abbreviation) - Amount: \(amount)")
            print("To: \(wallet.currency.abbreviation) - Amount: \(valueConverted)")
            
            guard self.hasBalanceToBuy(value: valueConverted, in: wallet) else {
                self.output?.buyFailed(with: .insufficientBalance)
                return
            }
            
            self.walletDataManager.incrementWallet(amount: amount, currency: self.coinSelected)
            self.transactionDataManager.setNewTransaction(type: .buy, operation: .credit, amount: amount, currency: self.coinSelected)
            
            self.walletDataManager.decrement(amount: valueConverted, from: wallet)
            self.transactionDataManager.setNewTransaction(type: .exchange, operation: .debit, amount: valueConverted, currency: wallet.currency)
            
            self.output?.buyed()
            
        } catch _ {
            self.output?.buyFailed(with: .exchangeRateUnavailable)
        }
    }
    
    private func hasBalanceToBuy(value: Double, in wallet: Wallet) -> Bool {
        return wallet.amount - value >= 0
    }
    
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

