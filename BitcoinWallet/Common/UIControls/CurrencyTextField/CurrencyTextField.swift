//
//  CurrencyTextField.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import UIKit

class CurrencyTextField: UITextField {

    var decimalSeparator: String { return App.Config.decimalSeparator }
    
    private let currencySymbolLabel: UILabel = UILabel()
    
    var currencyValue: Double {
        guard let textValue = self.text?.replacingOccurrences(of: self.decimalSeparator, with: "."), let value = Double(textValue) else {
            return 0.0
        }
        return value
    }
    
    @IBInspectable var currencySymbol: String? {
        set {
            self.currencySymbolLabel.text = newValue
            self.renderCurrencySymbolLabel(animated: true)
        }
        get {
            return self.currencySymbolLabel.text
        }
    }
    
    @IBInspectable var currencySymbolFont: UIFont? {
        set {
            self.currencySymbolLabel.font = newValue
        }
        get {
            return self.currencySymbolLabel.font
        }
    }
    
    @IBInspectable var currencySymbolColor: UIColor {
        set {
            self.currencySymbolLabel.textColor = newValue
        }
        get {
            return self.currencySymbolLabel.textColor
        }
    }
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    fileprivate func commonInit() {
       self.delegate = self
        self.keyboardType = .decimalPad
        self.leftView = self.currencySymbolLabel
        self.currencySymbolFont = UIFont.systemFont(ofSize: 15, weight: .medium)
        self.leftViewMode = .always
    }

    
    // MARK: - Overrides

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let padding: CGFloat = 8
        let maxLabelWidth: CGFloat = 100
        let labelWidth = self.currencySymbolLabel.sizeThatFits(CGSize(width: maxLabelWidth, height: bounds.height)).width
        return CGRect(x: 0, y: 0, width: labelWidth + padding, height: bounds.height)
    }
    
    private func renderCurrencySymbolLabel(animated: Bool) {
        let duration = animated ? 0.3 : 0.0
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            self.setNeedsLayout()
        }, completion: nil)
    }
}


// MARK: - UITextFieldDelegate

extension CurrencyTextField: UITextFieldDelegate {
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        // Character deleted
        guard !string.isEmpty else {
            if self.text == "0" + self.decimalSeparator {
                self.text = ""
                return false
            }
            return true
        }
        
        let text = textField.text ?? ""
        
        if text.isEmpty, string == self.decimalSeparator {
            self.text = "0" + self.decimalSeparator
            return false
        }
        
        if string == self.decimalSeparator {
            return !text.hasOccurrencesOf(self.decimalSeparator)
        } else if string == "0" && text == "0" {
            return false
        }
        
        return true
    }
}


