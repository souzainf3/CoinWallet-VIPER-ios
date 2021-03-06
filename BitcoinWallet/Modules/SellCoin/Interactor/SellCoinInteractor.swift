
import UIKit

// presenter ---->> interactor
protocol SellCoinInteractorInput {
    var outputCurrency: Currency? { get set}
    var debitWallet: Wallet? { get set}
    var walletsAvailable: [Wallet] { get }
    var currenciesAvailable: [Currency] { get }

    func sell(amount: Double)
}

// interactor ---->> presenter
protocol SellCoinInteractorOutput: class {
    func receivingCurrencyChanged(to currency: Currency)
    func debitWalletChanged(to wallet: Wallet)
    func unselectedWallet()
    func currencyForReceivingNotSelected()
    func buyed()
    func buyFailed(with error: SellCoinFail)
}

enum SellCoinFail: Error {
    case walletNotSelected
    case outputCurrencyNotSelected
    case invalidValue
    case exchangeRateUnavailable
    case insufficientBalance
}

class SellCoinInteractor: SellCoinInteractorInput {
    
    weak var output: SellCoinInteractorOutput?
    
    let walletDataManager: WalletDataManagerInput
    let exchangeRateDataManager: ExchangeRateDataManagerInput
    let transactionDataManager: TransactionDataManagerInput
    
    
    // Cretit value in Coin.
    var outputCurrency: Currency? {
        didSet {
            self.outputCurrencyValueChanged()
        }
    }
    
    // Debit in Wallet
    var debitWallet: Wallet? {
        didSet {
            self.walletValueChanged()
        }
    }
    
    // Only Wallets from virtual currencies
    var walletsAvailable: [Wallet] {
        return self.walletDataManager.fetchUserWallets().filter({ $0.currency.isVirtual })
    }
    
    // Currencies diferent from debit wallet
    var currenciesAvailable: [Currency] {
        return Currency.all.filter({ $0 != self.debitWallet?.currency
        })
    }
    
    
    // MARK: - Initializer
    
    init(walletDataManager: WalletDataManagerInput, exchangeRateDataManager: ExchangeRateDataManagerInput, transactionDataManager: TransactionDataManagerInput) {
        self.walletDataManager = walletDataManager
        self.exchangeRateDataManager = exchangeRateDataManager
        self.transactionDataManager = transactionDataManager
    }
    
    
    // MARK: - Input
    
    func sell(amount: Double) {
        guard let wallet = self.debitWallet else {
            self.output?.buyFailed(with: .walletNotSelected)
            return
        }

        guard amount > 0 else {
            self.output?.buyFailed(with: .invalidValue)
            return
        }
        
        guard let currency = self.outputCurrency else {
            self.output?.buyFailed(with: .outputCurrencyNotSelected)
            return
        }

        self.trySell(amount: amount, from: wallet, creditIn: currency)
    }
    
    
    // MARK: - Private
    
    private func trySell(amount: Double, from wallet: Wallet, creditIn currency: Currency) {
        do {
            let valueToCredit = try self.exchangeRateDataManager.convert(amount: amount, from: wallet.currency, to: currency)
            self.trySell(amount: amount, amountConverted: valueToCredit, from: wallet, creditIn: currency)

        } catch _ {
            // In erro, before everything, try update data
            self.exchangeRateDataManager.update(completionHandler: { manager in
                if manager.rate(from: wallet.currency, to: currency) != nil {
                    self.trySell(amount: amount, from: wallet, creditIn: currency)
                } else {
                    self.output?.buyFailed(with: .exchangeRateUnavailable)
                }
            })
        }
    }
    
    private func trySell(amount: Double, amountConverted: Double, from wallet: Wallet, creditIn currency: Currency) {
        print("Sell: \(wallet.currency.identifier) - Amount: \(amount)")
        print("Sell Payment: \(currency.identifier) - Amount: \(amountConverted)")
        
        guard self.hasBalanceToPay(value: amount, in: wallet) else {
            self.output?.buyFailed(with: .insufficientBalance)
            return
        }
        
        self.walletDataManager.incrementWallet(amount: amountConverted, currency: currency)
        self.transactionDataManager.setNewTransaction(type: .sell, operation: .credit, amount: amountConverted, currency: currency)
        
        self.walletDataManager.decrement(amount: amount, from: wallet)
        self.transactionDataManager.setNewTransaction(type: .sell, operation: .debit, amount: amount, currency: wallet.currency)
        
        self.output?.buyed()
    }
    
    private func hasBalanceToPay(value: Double, in wallet: Wallet) -> Bool {
        return wallet.amount - value >= 0
    }
    
    private func walletValueChanged() {
        guard let wallet = self.debitWallet else {
             self.output?.unselectedWallet()
            return
        }
        
        self.output?.debitWalletChanged(to: wallet)
        if let currency = self.outputCurrency, currency == wallet.currency {
            self.outputCurrency = nil
        }
    }
    
    private func outputCurrencyValueChanged() {
        if let currency = self.outputCurrency {
            self.output?.receivingCurrencyChanged(to: currency)
        } else {
            self.output?.currencyForReceivingNotSelected()
        }
    }

}


