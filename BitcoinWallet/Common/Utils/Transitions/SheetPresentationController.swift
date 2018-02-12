
import UIKit

enum ModalDisplayStyle: Equatable {
    case actionSheet
    case centeredModal
}

final class SheetPresentationController: UIPresentationController {
    
    // MARK: - Properties
    
    var modalDisplayStyle: ModalDisplayStyle = .actionSheet
    
    private var dimmingView: UIView!
    
    private var customPresentedView: UIView!
    
    override var presentedView: UIView? {
        return customPresentedView
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        switch self.modalDisplayStyle {
        case .actionSheet:
            return frameForActionSheet()
        case .centeredModal:
            return frameForMiddleModal()
        }
    }
    
    private func frameForActionSheet() -> CGRect {
        //        let size = customPresentedView.systemLayoutSizeFitting(
        //            containerView!.bounds.size,
        //            withHorizontalFittingPriority: UILayoutPriorityRequired,
        //            verticalFittingPriority: UILayoutPriorityFittingSizeLevel)
        //
        //        let (slice, _) = containerView!.bounds.divided(atDistance: size.height, from: .maxYEdge)
        //
        //        return slice
        
        
        var height =  presentedViewController.view.frame.height
        if presentedViewController.preferredContentSize.height > 0 {
            height = presentedViewController.preferredContentSize.height
        }
        
        return CGRect(x: 0, y: containerView!.bounds.height - height, width: containerView!.bounds.width, height: height)
    }
    
    private func frameForMiddleModal() -> CGRect {
        var height =  presentedViewController.view.frame.height
        if presentedViewController.preferredContentSize.height > 0 {
            height = presentedViewController.preferredContentSize.height
        }
        
        var width =  presentedViewController.view.frame.width
        if presentedViewController.preferredContentSize.width > 0 {
            width = presentedViewController.preferredContentSize.width
        }
        
        // TODO: - Ajustar de acordo com necessidade da UI
        return CGRect(x: (containerView!.bounds.width - width) / 2, y: (containerView!.bounds.height - height) / 2 , width: width, height: height)
    }
    
    
    // MARK: - UIPresentationController
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        if dimmingView == nil {
            dimmingView = UIView()
            switch self.modalDisplayStyle {
            case .actionSheet:
                dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            case .centeredModal:
                dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.7)
            }
            
            
            
            let cancelGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(cancel))
            dimmingView.addGestureRecognizer(cancelGestureRecognizer)
            
            dimmingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            dimmingView.frame = containerView!.bounds
            containerView!.addSubview(dimmingView)
        }
        
        if customPresentedView == nil {
            customPresentedView = presentedViewController.view
        }
        
        dimmingView.alpha = 0
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        })
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        coordinator.animate(alongsideTransition: { _ in
            self.customPresentedView.frame = self.frameOfPresentedViewInContainerView
        })
    }
    
    
    // MARK: - Private
    
    @objc private func cancel() {
        if  modalDisplayStyle == .actionSheet{
            presentedViewController.dismiss(animated: true, completion: nil)
        }
        
    }
}
