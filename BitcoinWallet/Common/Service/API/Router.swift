////
////  Router.swift
////  EscolarResponsavel
////
////  Created by Romilson Nunes on 15/01/17.
////  Copyright © 2017 Romilson Nunes. All rights reserved.
////
//
//import Foundation
//import Alamofire
//import ObjectMapper
//
//
//extension FixerApi {
//}
//
//struct EndPoint {
//    static let baseURLString: String = "https://api.fixer.io"
//    
//}
//
//extension Requestable  {
//    var baseURL: String { return EndPoint.baseURLString }
//}
//
//
//// MARK: - Bus Stops (Paradas)
//
//extension EndPoint {
////    latest?base=USD&symbols=BRL
////    https://api.fixer.io/latest?base=BRL&symbols=USD,GBP
//    
//    enum Latest<T>: Requestable {
//
//        case rates(base: String, symbols: [String]?)
//        
//        
//        // MARK: Requestable
//        
//        typealias ResponseType = T
//
//        var path: String {
//            
//            switch self {
//            case .rates(let base, let symbols):
//                var path = "/latest?base=\(base)"
//                if let symbols = symbols {
//                    path += "&" + symbols.joined(separator: ",")
//                }
//                return path
//            }
//        }
//    }
//}
//
//
//
