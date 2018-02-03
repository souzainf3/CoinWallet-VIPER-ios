//
//  Reusable.swift
//
//  Created by Romilson Nunes on 12/11/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import UIKit

// MARK: - Reusable Cell

public protocol Reusable: class {
    /// The reuse identifier to use when registering and later dequeuing a reusable cell
    static var reuseIdentifier: String { get }
}

// Default implementation
public extension Reusable {
    /// By default, use the name of the class as String for its reuseIdentifier
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}
