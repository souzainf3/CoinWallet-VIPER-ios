
import UIKit

class WalletWireframe: TabBarInterface, StoryboardInstanciate {
    
    let storyboardName = "Wallet"

    private(set) weak var walletViewController: UIViewController?

    
    // MARK: Public
    
    func configuredViewController() -> UIViewController {
        
        let walletViewController = newWalletViewController()
        let navigationController = UINavigationController(rootViewController: walletViewController)
        
        defer {
            self.walletViewController = walletViewController
        }
        return navigationController
    }
    
    
    func showScreenToBuyCoins() {
        
    }
    
    func showScreenToSellCoins() {
        
    }
    
    
    // MARK: - Private
    
    private func newWalletViewController() -> UIViewController {
        
        let walletViewController = viewControllerFromStoryboard(withIdentifier: "WalletViewController") as! WalletViewController
        
        let interactor = WalletInteractor(dataManager: WalletDataManager())
        
        let presenter = WalletPresenter(interactor: interactor, wireframe: self)
        presenter.output = walletViewController

        walletViewController.presenter = presenter
        interactor.output = presenter
       
        return walletViewController
    }
   
}

