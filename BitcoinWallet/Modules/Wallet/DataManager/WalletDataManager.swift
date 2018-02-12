//
//
//  Created by Romilson Nunes on 26/02/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation

// TODO: - Agrupar Data Managers em uma única camada (pasta)
protocol WalletDataManagerInput: class {
    func fetchUserWallet() -> [Wallet]
}


class WalletDataManager: WalletDataManagerInput {
    
    func fetchUserWallet() -> [Wallet] {
        // TODO: - Remove Mock
        return [
            Wallet(currency: .real, amount: 100000.0),
            Wallet(currency: .bitcoin, amount: 0.002),
            Wallet(currency: .britta, amount: 0.0)
        ]
    }
    
}


