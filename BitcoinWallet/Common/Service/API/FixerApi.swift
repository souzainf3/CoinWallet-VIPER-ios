
import Foundation
import ObjectMapper
import Alamofire

class FixerApi: APIRequest, APIURLProtocol {
    private static let client = FixerApi()
    
    let baseUrl: String = "https://api.fixer.io/"
    
    private override init() {
        super.init()
    }
}

extension FixerApi {
    class ExchangeRate: APIBaseModel {
        var base: String = ""
        var date: Date?
        var rates: [String: Double] = [:] //["BRL" : 0.233]

        override func mapping(map: Map) {
            base          <- map["base"]
            date          <- (map["date"], self.dateTransform(format: "yyyy-MM-dd"))
            rates         <- map["rates"]
        }
    }
}

// MARK: - EndPoints

extension FixerApi {
    
    /**
     GET exchange rates from a currency
     
     - parameter currency: Base currency
     - parameter symbols: Currency symbols to rates
     - parameter completion: Callback for request completion
     */
    static func getExchangeRates(from currency: String, to symbols: [String]?, completion: @escaping (ApiResult<FixerApi.ExchangeRate>)->Void ) {

        var url = client.baseUrl + "latest?base=\(currency)"
        if let symbols = symbols?.joined(separator: ","), !symbols.isEmpty {
           url += "&symbols=\(symbols)"
        }
        client.requestObject(FixerApi.ExchangeRate.self, url: url, method: HTTPMethod.get, completionHandler: completion)
    }
    
}


