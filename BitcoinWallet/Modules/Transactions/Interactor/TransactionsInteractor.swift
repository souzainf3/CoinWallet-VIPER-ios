
import UIKit

// presenter ---->> interactor
protocol TransactionsInteractorInput {
    func fetchTransactions()
}

// interactor ---->> presenter
protocol TransactionsInteractorOutput: class {
    func fetchedTransactions(items: [Transaction])
}

class TransactionsInteractor: TransactionsInteractorInput {
    
    weak var output: TransactionsInteractorOutput?
    
    let transactionDataManager: TransactionDataManagerInput
    
    // MARK: - Initializer
    
    init(transactionDataManager: TransactionDataManagerInput) {
        self.transactionDataManager = transactionDataManager
        self.transactionDataManager.observeTransactionsUpdate {
            self.fetchTransactions()
        }
    }
    
    
    // MARK: - Input
    
    func fetchTransactions() {
        self.output?.fetchedTransactions(items: self.transactionDataManager.transactions(ascending: true))
    }
    
}



