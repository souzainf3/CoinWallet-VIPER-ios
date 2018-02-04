

import Foundation


// presenter ---->> view
protocol WalletPresenterOutput: class {
    func reloadWallet(viewModel: WalletViewModel)
}

// view ---->> presenter
protocol WalletPresenterInput {
    func viewDidLoad()
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
        self.showUserWallet()
    }
    
    
    // MARK: - Private
    
    private func showUserWallet() {
        let items = self.interactor.getUserWallet().map({
            WalletItem(
                title: $0.currency.abbreviation,
                amountValue: "\($0.currency.symbol) \($0.amount)",
                icon: (symbol: $0.currency.symbol, color: $0.currency.color)
            )
        })
        
        self.output?.reloadWallet(viewModel: WalletViewModel(title: "Saldo", items: items))
    }
}

// MARK: - WalletInteractorOutput

extension WalletPresenter: WalletInteractorOutput {
}


