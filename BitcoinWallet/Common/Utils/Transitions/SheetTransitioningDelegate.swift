//
//  ActionSheetTransitioningDelegate.swift
//
//  Created by Romilson Nunes on 02/10/17.
//

import UIKit

class SheetTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
   
    private(set) var modalDisplayStyle: ModalDisplayStyle = .actionSheet

    init(modalDisplayStyle: ModalDisplayStyle) {
        self.modalDisplayStyle = modalDisplayStyle
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let controller = SheetPresentationController(presentedViewController: presented, presenting: presenting)
        controller.modalDisplayStyle = self.modalDisplayStyle
        
        return controller
    }
}
