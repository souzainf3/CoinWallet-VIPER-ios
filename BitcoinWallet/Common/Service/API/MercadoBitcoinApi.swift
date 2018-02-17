
import Foundation
import ObjectMapper
import Alamofire

class MercadoBitcoinApi: APIRequest, APIURLProtocol {
    private static let client = MercadoBitcoinApi()
    
    let baseUrl: String = "https://www.mercadobitcoin.net/api/"
    
    private override init() {
        super.init()
    }
}


// MARK: - Models

extension MercadoBitcoinApi {
    
    enum Coin: String {
        case btc // Bitcoin
        case ltc // Litecoin
        case bch // BCash
    }
    
    class Ticker: APIBaseModel {
        var high: String = ""
        var low: String = ""
        var volume: String = ""
        var last: String = ""
        var buy: String = ""
        var sell: String = ""
        var date: Date?
        
        override func mapping(map: Map) {
            high         <- map["ticker.high"]
            low          <- map["ticker.low"]
            volume       <- map["ticker.vol"]
            last         <- map["ticker.last"]
            buy          <- map["ticker.buy"]
            sell         <- map["ticker.sell"]

            var timestamp: Double = 0
            timestamp <- map["ticker.date"]
            date = Date(timeIntervalSince1970: timestamp)
        }
    }
}


// MARK: - EndPoints

extension MercadoBitcoinApi {
    /**
     GET summary of the last 24 hours of negotiations
     
     - parameter coin: virtual currency
     - parameter completion: Callback for request completion
     */
    static func getTicker(from coin: MercadoBitcoinApi.Coin, completion: @escaping (ApiResult<MercadoBitcoinApi.Ticker>)->Void ) {
        let url = client.baseUrl + "\(coin.rawValue)/ticker/"
        client.requestObject(MercadoBitcoinApi.Ticker.self, url: url, method: HTTPMethod.get, completionHandler: completion)
    }
}



