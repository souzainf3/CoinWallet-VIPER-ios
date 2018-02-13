
import UIKit

class WalletWireframe: TabBarInterface, StoryboardInstanciate {
    
    let storyboardName = "Wallet"

    private(set) weak var walletViewController: UIViewController?

    let buyCoinWireframe: BuyCoinWireframe

    
    // MARK: Public
    
    init(buyCoinWireframe: BuyCoinWireframe) {
        self.buyCoinWireframe = buyCoinWireframe
    }
    
    func configuredViewController() -> UIViewController {
        
        let walletViewController = newWalletViewController()
        let navigationController = UINavigationController(rootViewController: walletViewController)
        
        defer {
            self.walletViewController = walletViewController
        }
        return navigationController
    }
    
    
    func showScreenToBuyCoins() {
        guard let navigation = self.walletViewController?.navigationController else {
            return
        }
        self.buyCoinWireframe.present(in: navigation)
    }
    
    func showScreenToSellCoins() {
        
    }
    
    
    // MARK: - Private
    
    private func newWalletViewController() -> UIViewController {
        
        let walletViewController = viewControllerFromStoryboard(withIdentifier: "WalletViewController") as! WalletViewController
        
        let walletDataManager = WalletDataManager(database: DatabaseManager(configuration: .basic))
        let interactor = WalletInteractor(dataManager: walletDataManager)
        
        let presenter = WalletPresenter(interactor: interactor, wireframe: self)
        presenter.output = walletViewController

        walletViewController.presenter = presenter
        interactor.output = presenter
        
        return walletViewController
    }
   
}

