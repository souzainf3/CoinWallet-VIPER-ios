
import UIKit

// presenter ---->> interactor
protocol ExchangeRateInteractorInput {
    func fetchExchangeRate()
}

// interactor ---->> presenter
protocol ExchangeRateInteractorOutput: class {
    func didUpdateExchangeRate(_ exchangeRate: ExchangeRate)
}

class ExchangeRateInteractor: ExchangeRateInteractorInput {

    weak var output: ExchangeRateInteractorOutput?
    
    let dataManager: ExchangeRateDataManagerInput
    
    let standardCurrency: Currency = .real
    
    
    // MARK: - Initializers
    
    init(dataManager: ExchangeRateDataManagerInput) {
        self.dataManager = dataManager
    }
    
    
    // MARK: Input
    
    func fetchExchangeRate() {
        if let rate = self.dataManager.exchangeRate(from: standardCurrency) {
            self.output?.didUpdateExchangeRate(rate)
        } else {
            // TODO: - Request Info from API
        }
    }
}


