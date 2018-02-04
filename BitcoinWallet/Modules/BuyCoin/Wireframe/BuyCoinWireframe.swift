
import UIKit

class BuyCoinWireframe: StoryboardInstanciate {
    
    let storyboardName = "BuyCoin"

    private(set) weak var walletViewController: UIViewController?

    
    // MARK: - Public
    
    func present(in navigationController: UINavigationController) {
        
       let viewController = viewControllerFromStoryboard(withIdentifier: "BuyCoinViewController") as! BuyCoinViewController
        
        let interactor = BuyCoinInteractor(dataManager: BuyCoinDataManager())
        
        let presenter = BuyCoinPresenter(interactor: interactor, wireframe: self)
        presenter.output = viewController

        viewController.presenter = presenter
        interactor.output = presenter

        navigationController.pushViewController(viewController, animated: true)
    }
   
}
