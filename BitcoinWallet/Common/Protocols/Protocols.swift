//
//  Protocols.swift
//
//  Created by Romilson Nunes on 03/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit



// MARK: - StoryboardInstanciate Protocol

protocol StoryboardInstanciate {
    static var storyboardName: String { get }
    static func viewControllerFromStoryboard(withIdentifier identifier: String) -> UIViewController
}

extension StoryboardInstanciate {
    
    static var storyboard: UIStoryboard {
        return UIStoryboard(name: self.storyboardName, bundle: nil)
    }
    
    static func viewControllerFromStoryboard(withIdentifier identifier: String) -> UIViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}






