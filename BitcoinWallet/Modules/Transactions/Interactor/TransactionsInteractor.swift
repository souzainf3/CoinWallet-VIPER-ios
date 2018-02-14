
import UIKit

// presenter ---->> interactor
protocol TransactionsInteractorInput {
}

// interactor ---->> presenter
protocol TransactionsInteractorOutput: class {
}

class TransactionsInteractor: TransactionsInteractorInput {
    
    weak var output: TransactionsInteractorOutput?
    
    let walletDataManager: WalletDataManagerInput
    let transactionDataManager: TransactionDataManagerInput
    
    
    // MARK: - Initializer
    
    init(walletDataManager: WalletDataManagerInput, transactionDataManager: TransactionDataManagerInput) {
        self.walletDataManager = walletDataManager
        self.transactionDataManager = transactionDataManager
    }
    
    
    // MARK: - Input
    
}



