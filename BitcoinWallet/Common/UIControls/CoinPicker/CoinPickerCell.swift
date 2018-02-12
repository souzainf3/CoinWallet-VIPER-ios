
import UIKit

class CoinPickerCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!
}

extension CoinPickerCell {
    
    func configure(with item: CoinPickerDisplayItem) {
        self.titleLabel.text = item.title
        self.amountLabel.text = item.amountValue
        self.currencyLabel.text = item.currencyFlag.abbreviation
        self.currencyLabel.backgroundColor = item.currencyFlag.color
        
        if item.amountValue.isEmpty {
            self.balanceLabel.text = nil
        } else {
            self.balanceLabel.text = "saldo".uppercased()
        }
    }
}

