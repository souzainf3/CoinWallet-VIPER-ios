
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
    
    
    // MARK: - Initializers
    
    init(dataManager: ExchangeRateDataManagerInput) {
        self.dataManager = dataManager
    }
    
    
    // MARK: Input
    
    func fetchExchangeRate() {
        let otherCurrencies = Currency.all.filter({ $0 != self.dataManager.baseExchangeRate.currency })
        let rates = otherCurrencies.flatMap({self.dataManager.baseExchangeRate.rate(from: $0)})
        if rates.count == otherCurrencies.count {
            // The fetch of Exchange Rate this completed
            self.output?.didUpdateExchangeRate(self.dataManager.baseExchangeRate)
        } else {
            // Fetch rates from API
            // TODO: - Observer update changes from Data Manager
            self.dataManager.update()
        }

    }
}


