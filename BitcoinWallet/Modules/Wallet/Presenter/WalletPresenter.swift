

import Foundation


// presenter ---->> view
protocol WalletPresenterOutput: class {
    func reloadWallet(viewModel: WalletViewModel)
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
    let interactor: WalletInteractorInput

    
    // MARK: Initializes
    
    init(interactor: WalletInteractorInput, wireframe: WalletWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    
    // MARK: Input
    
    func viewDidLoad() {
        self.showUserWallets(self.interactor.fetchUserWallets())
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
                title: $0.currency.name.capitalized,
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


