
import UIKit

// presenter ---->> interactor
protocol BuyCoinInteractorInput {
}

// interactor ---->> presenter
protocol BuyCoinInteractorOutput: class {
}

class BuyCoinInteractor: BuyCoinInteractorInput {

    weak var output: BuyCoinInteractorOutput?
    
    let dataManager: BuyCoinDataManagerInput
    
    init(dataManager: BuyCoinDataManagerInput) {
        self.dataManager = dataManager
    }
    
    
    // MARK: Input
    
}

