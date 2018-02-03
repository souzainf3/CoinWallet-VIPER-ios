
import UIKit

class ChildrenWireframe {
    
    private let storyboard = UIStoryboard(name: "Main", bundle: nil)
    private(set) weak var childrenViewController: ChildrenViewController?

    // MARK: Public
    
    func presentChildrenInterface(in topController: UIViewController) {
        let childrenViewController = storyboard.instantiateViewController(withIdentifier: "ChildrenViewController") as! ChildrenViewController
        
        let interactor = ChildrenInteractor(childrenDataManager: ChildrenDataManager())
        
        let presenter = ChildrenPresenter(interactor: interactor, wireframe: self)
        presenter.output = childrenViewController

        childrenViewController.presenter = presenter
//        interactor.output = presenter
       
        let navigationController = UINavigationController(rootViewController: childrenViewController)
        topController.present(navigationController, animated: true, completion: nil)
        
        self.childrenViewController = childrenViewController
    }
    
    func closeChildrenScreen() {
        self.childrenViewController?.dismiss(animated: true, completion: nil)
    }
   
}

