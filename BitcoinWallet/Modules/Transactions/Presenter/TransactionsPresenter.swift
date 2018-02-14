

import Foundation

// presenter ---->> view
protocol TransactionsPresenterOutput: class {
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
    }
    
}


// MARK: - TransactionsInteractorOutput

extension TransactionsPresenter: TransactionsInteractorOutput {
}




