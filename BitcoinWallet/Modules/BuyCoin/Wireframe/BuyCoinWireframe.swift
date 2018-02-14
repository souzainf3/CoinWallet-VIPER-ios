
import UIKit

class BuyCoinWireframe: StoryboardInstanciate {
    
    let storyboardName = "BuyCoin"

    private(set) weak var walletViewController: UIViewController?

    
    // MARK: - Public
    
    func present(in navigationController: UINavigationController) {
        
       let viewController = viewControllerFromStoryboard(withIdentifier: "BuyCoinViewController") as! BuyCoinViewController
        
        let walletDataManager = WalletDataManager(database: DatabaseManager(configuration: .standard))
        let transactionDataManager = TransactionDataManager(database: DatabaseManager(configuration: .standard))
        
        let interactor = BuyCoinInteractor(
            walletDataManager: walletDataManager,
            exchangeRateDataManager: ExchangeRateDataManager(),
            transactionDataManager: transactionDataManager
        )
        
        let presenter = BuyCoinPresenter(interactor: interactor, wireframe: self)
        presenter.output = viewController

        viewController.presenter = presenter
        interactor.output = presenter

        navigationController.pushViewController(viewController, animated: true)
        
        self.walletViewController = viewController
    }
    
    func dismissBuyScreen() {
        self.walletViewController?.navigationController?.popViewController(animated: true)
    }
   
}

