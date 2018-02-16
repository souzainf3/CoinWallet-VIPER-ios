//
//  Created by Romilson Nunes on 15/01/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.

import Alamofire
import RxSwift


// MARK: - Requestable Protocol

protocol Requestable: URLRequestConvertible {
    
    associatedtype ResponseType
    
    var baseURL: String { get }
    
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var query: String? { get }
    var parameters: [String: AnyObject] { get }
    var encoding: ParameterEncoding { get }
    var headers: [String: String]? { get }
}


extension Requestable {
    
    // MARK: - Properties
    
    var method: Alamofire.HTTPMethod {
        return .get
    }
    var encoding: ParameterEncoding {
        return  Alamofire.URLEncoding.default
    }
    var headers: [String: String]? {
        return nil
    }
    
    var parameters: [String : AnyObject] {
        return [:]
    }
    
    var query: String? { return nil }


    // MARK: - Public
    
    public func asURLRequest() throws -> URLRequest {
        guard let url = makeURL() else {
            throw RequestableURLError.malformedUrl
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        request.allHTTPHeaderFields = self.headers
        
        return try encoding.encode(request, with: parameters)
    }
    
  
    // MARK: - Private

    private func makeURL() -> URL? {
        let urlComponents = NSURLComponents(string: baseURL)
        urlComponents?.path = (urlComponents?.path ?? "").appendingPathComponent(path: self.path)
        urlComponents?.query = self.query
        
        return urlComponents?.url
    }
}


// MARK: - Helpers

private extension String {
    func appendingPathComponent(path: String) -> String {
        let string = self as NSString
        return string.appendingPathComponent(path)
    }
}


