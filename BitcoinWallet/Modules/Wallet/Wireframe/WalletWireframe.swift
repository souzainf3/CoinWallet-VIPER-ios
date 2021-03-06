
import UIKit

class WalletWireframe: TabBarInterface, StoryboardInstanciate {
    
    let storyboardName = "Wallet"

    private(set) weak var walletViewController: UIViewController?

    let buyCoinWireframe: BuyCoinWireframe
    let sellCoinWireframe: SellCoinWireframe
    
    // MARK: Public
    
    init(buyCoinWireframe: BuyCoinWireframe, sellCoinWireframe: SellCoinWireframe) {
        self.buyCoinWireframe = buyCoinWireframe
        self.sellCoinWireframe = sellCoinWireframe
    }
    
    func configuredViewController() -> UIViewController {
        
        let walletViewController = newWalletViewController()
        walletViewController.tabBarItem = UITabBarItem(title: "Carteira", image: #imageLiteral(resourceName: "wallet"), tag: 0)
        let navigationController = CustomNavigationController(rootViewController: walletViewController)
       
        if #available(iOS 11.0, *) {
            navigationController.navigationBar.prefersLargeTitles = true
        }
        
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
        guard let navigation = self.walletViewController?.navigationController else {
            return
        }
        self.sellCoinWireframe.presentSellScreen(in: navigation)
    }
    
    
    // MARK: - Private
    
    private func newWalletViewController() -> UIViewController {
        
        let walletViewController = viewControllerFromStoryboard(withIdentifier: "WalletViewController") as! WalletViewController
        
        let walletDataManager = WalletDataManager(database: DatabaseManager(configuration: .standard))
        let walletInteractor = WalletInteractor(dataManager: walletDataManager)
        let exchangeRateInteractor = ExchangeRateInteractor(dataManager: ExchangeRateDataManager.shared)
        
        let presenter = WalletPresenter(walletInteractor: walletInteractor, exchangeRateInteractor: exchangeRateInteractor, wireframe: self)
        presenter.output = walletViewController

        walletViewController.presenter = presenter
        walletInteractor.output = presenter
        exchangeRateInteractor.output = presenter
        
        return walletViewController
    }
   
}

