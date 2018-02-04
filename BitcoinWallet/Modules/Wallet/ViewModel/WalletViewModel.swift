
import UIKit

struct WalletViewModel {
    let title: String
    let items: [WalletItem]
}

struct WalletItem {
    let title: String
    let amountValue: String
    let icon: (symbol: String, color: UIColor)
}
