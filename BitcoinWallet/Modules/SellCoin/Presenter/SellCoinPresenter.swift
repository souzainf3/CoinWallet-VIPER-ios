

import Foundation

// presenter ---->> view
protocol SellCoinPresenterOutput: class {
    func showLoading()
    func hideLoading()
    func configureOutputCurrency(_ currency: Currency)
    func configureDebitWallet(_ wallet: Wallet)
    func configureEmptyDebitWallet(message: String)
    func configureEmptyCreditCurrency(message: String)
    func showWalletPicker(title: String, wallets: [Wallet], walletSelected: Wallet?)
    func showCoinPicker(title: String, currencies: [Currency], currencySelected: Currency?)
    func showAlert(title: String, message: String, buttonTitle: String, onDismiss: (()->Void)?)
}

// view ---->> presenter
protocol SellCoinPresenterInput {
    func viewDidLoad()
    func pressedWalletSelection()
    func pressedCurrencySelection()
    func didSelected(currency: Currency)
    func didSelected(wallet: Wallet)
    func didPressedSell(amount: Double)
}

class SellCoinPresenter: SellCoinPresenterInput {
    
    weak var output: SellCoinPresenterOutput?
    weak var wireframe: SellCoinWireframe?
    var interactor: SellCoinInteractorInput
    
    
    // MARK: - Initializes
    
    init(interactor: SellCoinInteractorInput, wireframe: SellCoinWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    
    // MARK: - Input
    
    func viewDidLoad() {
        self.configureOutputCurrency()
        self.configureDebitWallet()
    }
    
    func pressedWalletSelection() {
        self.output?.showWalletPicker(
            title: "Selecione uma carteira",
            wallets: self.interactor.walletsAvailable,
            walletSelected: self.interactor.debitWallet
        )
    }
    
    func pressedCurrencySelection() {
        self.output?.showCoinPicker(
            title: "Selecione a moeda de recebimento",
            currencies: self.interactor.currenciesAvailable,
            currencySelected: self.interactor.outputCurrency
        )
    }
    
    func didSelected(currency: Currency) {
        self.interactor.outputCurrency = currency
    }
    
    func didSelected(wallet: Wallet) {
        self.interactor.debitWallet = wallet
    }
    
    func didPressedSell(amount: Double) {
        self.output?.showLoading()
        self.interactor.sell(amount: amount)
    }

    
    // MARK: - Private
    
    private func configureOutputCurrency() {
        if let currency = self.interactor.outputCurrency {
            self.output?.configureOutputCurrency(currency)
        } else {
            self.output?.configureEmptyCreditCurrency(message: "Selecione uma moeda")
        }
    }
    
    private func configureDebitWallet() {
        if let wallet = self.interactor.debitWallet {
            self.output?.configureDebitWallet(wallet)
        } else {
            self.output?.configureEmptyDebitWallet(message: "Selecione uma carteira")
        }
    }
    
}


// MARK: - SellCoinInteractorOutput

extension SellCoinPresenter: SellCoinInteractorOutput {
    func receivingCurrencyChanged(to currency: Currency) {
        self.output?.configureOutputCurrency(currency)
    }
    
    func debitWalletChanged(to wallet: Wallet) {
        self.output?.configureDebitWallet(wallet)
    }
    
    func unselectedWallet() {
        self.output?.configureEmptyDebitWallet(message: "Selecione uma carteira")
    }
    
    func currencyForReceivingNotSelected() {
        self.output?.configureEmptyCreditCurrency(message: "Selecione uma moeda")
    }
    
    func buyed() {
        self.output?.hideLoading()
        self.output?.showAlert(title: "Venda realizada com sucesso", message: "", buttonTitle: "OK", onDismiss: {
            self.wireframe?.dismissSellScreen()
        })
    }
    
    func buyFailed(with error: SellCoinFail) {
        self.output?.hideLoading()

        let message: String
        switch error {
        case .exchangeRateUnavailable:
            message = "Taxa de câmbio indisponível no momento. Tente novamente mais tarte."
        case .insufficientBalance:
            message = "A carteira selecionada não tem saldo suficiente pra essa transação."
        case .invalidValue:
            message = "O valor inserido é inválido."
        case .walletNotSelected:
            message = "Selecione uma carteira a ser debitada."
        case .outputCurrencyNotSelected:
            message = "Selecione a moeda para recebimento."
        }
        self.output?.showAlert(title: "Atenção!", message: message, buttonTitle: "OK", onDismiss: nil)
    }
}



