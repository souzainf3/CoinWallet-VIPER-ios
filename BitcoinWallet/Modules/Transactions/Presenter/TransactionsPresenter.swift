

import Foundation

// presenter ---->> view
protocol TransactionsPresenterOutput: class {
    func showTransactionItems(items: [TransactionDisplayItem])
}

// view ---->> presenter
protocol TransactionsPresenterInput {
    func viewDidLoad()
}

class TransactionsPresenter: TransactionsPresenterInput {
    
    weak var output: TransactionsPresenterOutput?
    weak var wireframe: TransactionsWireframe?
    var interactor: TransactionsInteractorInput
    
    
    // MARK: Initializes
    
    init(interactor: TransactionsInteractorInput, wireframe: TransactionsWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    
    // MARK: Input
    
    func viewDidLoad() {
        self.interactor.fetchTransactions()
    }
    
}


// MARK: - TransactionsInteractorOutput

extension TransactionsPresenter: TransactionsInteractorOutput {
    func fetchedTransactions(items: [Transaction]) {
        let displayItems = items.flatMap({
            TransactionDisplayItem(
                title: "\($0.operation == .debit ? "-" : "")\($0.currency.symbol) \($0.amount)",
                titleColor: $0.operation.color,
                description: $0.operation == .credit ? "Crédito de venda/troca de valores" : "Pagamento de valores",
                date: $0.date.toString(format: "dd/MM/yyyy").uppercased(),
                currency: (name: $0.currency.name.capitalized, abbreviation: $0.currency.abbreviation, color: $0.currency.color)
            )
        })
        self.output?.showTransactionItems(items: displayItems)
    }
}


