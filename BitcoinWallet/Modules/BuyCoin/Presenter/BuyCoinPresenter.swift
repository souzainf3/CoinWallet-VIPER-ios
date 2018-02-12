

import Foundation

// presenter ---->> view
protocol BuyCoinPresenterOutput: class {
    func showLoading()
    func hideLoading()
    func configureSelectedCoin(_ coin: Currency)
    func configureWalletNotSelected()
    func configureSelectedWallet(_ wallet: Wallet)
    
    func showWalletPicker(title: String, wallets: [Wallet], walletSelected: Wallet?)
    func showCoinPicker(title: String, coins: [Currency], coinSelected: Currency?)
    
    func showAlert(title: String, message: String, buttonTitle: String, onDismiss: (()->Void)?)

}

// view ---->> presenter
protocol BuyCoinPresenterInput {
    func viewDidLoad()
    func walletSelectionPressed()
    func coinSelectionPressed()
    func didSelected(coin: Currency)
    func didSelected(wallet: Wallet)
    func didPressedBuy(value: Double)
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
        self.configureCoin()
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
    
    func didPressedBuy(value: Double) {
        self.output?.showLoading()
        self.interactor.buy(amount: value)
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
    
    func configureSelectedCoin(_ coin: Currency) {
        self.output?.configureSelectedCoin(coin)
    }
    
    func configureSelectedWallet(_ wallet: Wallet) {
        self.output?.configureSelectedWallet(wallet)
    }
    
    func configureUnselectedWallet() {
        self.output?.configureWalletNotSelected()
    }
    
    func buyed() {
        self.output?.hideLoading()
        self.output?.showAlert(title: "Compra realizada com sucesso", message: "", buttonTitle: "OK", onDismiss: {
            self.wireframe?.dismissBuyScreen()
        })
    }

    func buyFailed(with error: BuyCoinFail) {
        self.output?.hideLoading()

        let message: String
        switch error {
        case .exchangeRateUnavailable:
            message = "Taxa de câmbio indisponivel no momento. Tente novamente mais tarte."
        case .insufficientBalance:
            message = "A carteira selecionada não tem saldo suficiente para essa operação."
        case .invalidValue:
            message = "O valor inserido é inválido."
        case .walletNotSelected:
            message = "Selecione uma carteira a ser debitada."
        }
        
        self.output?.showAlert(title: "Atenção!", message: message, buttonTitle: "OK", onDismiss: nil)
    }
}


