

import Foundation


// presenter ---->> view
protocol WalletPresenterOutput: class {
    func reloadWallet(viewModel: WalletViewModel)
    func showCurrencyPrices(description: String)
}

// view ---->> presenter
protocol WalletPresenterInput {
    func viewDidLoad()
    func didPressedBuyButton()
    func didPressedSellButton()
}

class WalletPresenter: WalletPresenterInput {
    
    weak var output: WalletPresenterOutput?
    weak var wireframe: WalletWireframe?
    let walletInteractor: WalletInteractorInput
    let exchangeRateInteractor: ExchangeRateInteractorInput

    
    // MARK: Initializes
    
    init(walletInteractor: WalletInteractorInput, exchangeRateInteractor: ExchangeRateInteractorInput, wireframe: WalletWireframe) {
        self.walletInteractor = walletInteractor
        self.exchangeRateInteractor = exchangeRateInteractor
        self.wireframe = wireframe
    }
    
    
    // MARK: Input
    
    func viewDidLoad() {
        self.showUserWallets(self.walletInteractor.fetchUserWallets())
        self.exchangeRateInteractor.fetchExchangeRate()
    }
    
    func didPressedBuyButton() {
        self.wireframe?.showScreenToBuyCoins()
    }
    
    func didPressedSellButton() {
        self.wireframe?.showScreenToSellCoins()
    }
    
    
    // MARK: - Private
    
    private func showUserWallets(_ wallets: [Wallet]) {
        let items = wallets.map({
            WalletItem(
                title: $0.currency.name,
                amountValue: $0.amountFormatted,
                tag: (currency: $0.currency.abbreviation, color: $0.currency.color)
            )
        })
        
        self.output?.reloadWallet(viewModel: WalletViewModel(title: "Saldo", items: items))
    }
}


// MARK: - WalletInteractorOutput

extension WalletPresenter: WalletInteractorOutput {
    func didUpdateUserWallets(_ wallets: [Wallet]) {
        self.showUserWallets(wallets)
    }
}


// MARK: - ExchangeRateInteractorOutput

extension WalletPresenter: ExchangeRateInteractorOutput {
    func didUpdateExchangeRate(_ exchangeRate: ExchangeRate) {
        let title = "Cotação em \(exchangeRate.date.toString(format: "dd/MM/yyyy")):"
        let currency = "1 \(exchangeRate.currency.abbreviation)"
        let description = exchangeRate.rates.reduce(title, {$0 + "\n\(currency) = \($1.value.toCurrencyFormatedString()) \($1.currency.abbreviation)"})
        self.output?.showCurrencyPrices(description: description)
    }
    
    
}


