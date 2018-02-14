//
//  Extensions.swift
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import UIKit


// MARK: - UIWindow

public extension UIWindow {
    
    func topViewController() -> UIViewController? {
        
        var topController = self.rootViewController //[UIApplication sharedApplication].keyWindow.rootViewController;
        
        while let viewController = topController?.presentedViewController {
            topController = viewController
        }
        return topController;
    }
}


// MARK: - Alert

extension UIAlertController {
    
    func show() {
        if let topViewController = UIApplication.shared.keyWindow?.topViewController() {
            topViewController.present(self, animated: true, completion: nil)
        }
    }
    
    @discardableResult
    static func show(title: String, message: String, cancelButtonTitle: String, confirmationButtonTitle: String? = nil, dissmissBlock: (()-> Void)? = nil , cancelBlock: (()-> Void)? = nil) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // Cancel Button
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: UIAlertActionStyle.cancel, handler: { (action) -> Void in
            cancelBlock?()
        }))
        // Confirmation button
        if let title = confirmationButtonTitle {
            alert.addAction(UIAlertAction(title: title, style: UIAlertActionStyle.default, handler: { (action) -> Void in
                dissmissBlock?()
            }))
        }
        
        alert.show()
        
        return alert
    }
}


// MARK: - String

extension String {
    
    // Case sensitive
    func hasOccurrencesOf(_ substring: String?) -> Bool {
        return count(occurrencesOf: substring) > 0
    }
    
    func count(occurrencesOf substring: String?) -> Int {
        guard let substring = substring, !substring.isEmpty else { return 0 }

        var searchRange: Range<String.Index>?
        var count = 0
        while let foundRange = range(of: substring, options: .diacriticInsensitive, range: searchRange) {
            searchRange = Range(uncheckedBounds: (lower: foundRange.upperBound, upper: endIndex))
            count += 1
        }
        return count
    }
}


// MARK: - Date

extension Date {
    
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        
        return formatter.string(from: self)
    }
}

