

import Foundation


// presenter ---->> view
protocol BuyCoinPresenterOutput: class {
}

// view ---->> presenter
protocol BuyCoinPresenterInput {
    func viewDidLoad()
}

class BuyCoinPresenter: BuyCoinPresenterInput {
    
    weak var output: BuyCoinPresenterOutput?
    weak var wireframe: BuyCoinWireframe?
    let interactor: BuyCoinInteractorInput

    
    // MARK: Initializes
    
    init(interactor: BuyCoinInteractorInput, wireframe: BuyCoinWireframe) {
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    
    // MARK: Input
    
    func viewDidLoad() {
    }
    
    
    // MARK: - Private
    
}

// MARK: - WalletInteractorOutput

extension BuyCoinPresenter: BuyCoinInteractorOutput {
}


