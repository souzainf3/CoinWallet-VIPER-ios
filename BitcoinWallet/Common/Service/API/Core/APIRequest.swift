//
//  Api.swift
//
//  Created by Romilson Nunes on 15/01/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper



// MARK: - Client

class APIRequest {
    private let manager = Alamofire.SessionManager.default
    
    public typealias JSONCompletionHandler = (ApiResult<JSON>) -> Void
    public typealias JSON = Any
}


// MARK: - Generic JSON Request

extension APIRequest {
    
    /**
     Create a request using the custom manager for the specified method, URL string, parameters, parameter encoding.
     Response data serialized to JSON
     
     - parameter method: The HTTP method.
     - parameter URLString: The URL string.
     - parameter parameters: The request parameters.
     - parameter encoding: The parameters encoding. `.URL` by default.
     
     - parameter completionHandler: Completion Handler with JSON object serialized.
     
     - returns: The created request.
     */
    @discardableResult
    func request(url: String, method: Alamofire.HTTPMethod, parameters: [String : Any]? = nil, encoding: ParameterEncoding = URLEncoding.default, headers: [String : String]? = nil, completionHandler: @escaping JSONCompletionHandler) -> Request {
        
        let request = self.manager.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                // Check if request is canceled
                if let code = response.result.error?._code, code == NSURLErrorCancelled {
                    return
                }
               
                switch response.result {
                case .success:
                    if let data = response.result.value {
                        completionHandler(ApiResult<JSON>.success(data))
                    } else {
                        completionHandler(ApiResult<JSON>.failure(.typeMismatch))
                    }
                case .failure:
                    let error = self.errorFrom(dataResponse: response)
                    completionHandler(ApiResult<JSON>.failure(error))
                }
        }
        
        return request
    }
}


// MARK: - Serializable

extension APIRequest: ApiResultSerializable {
    
    func requestObject<T: Mappable>(_ type: T.Type, url: String, method: Alamofire.HTTPMethod, parameters: [String : Any]? = nil, headers: [String : String]? = nil, completionHandler: @escaping (ApiResult<T>)->Void) {
        let task = self.request(
            url: url,
            method: method,
            parameters: parameters,
            headers: headers,
            completionHandler: { response in
                switch response {
                case .success(let json):
                    completionHandler(self.mapObject(T.self, from: json))
                case .failure(let error):
                    completionHandler(ApiResult<T>.failure(error))
                }
        })
        task.resume()
    }
    
    func requestObjects<T: Mappable>(_ type: T.Type, url: String, method: Alamofire.HTTPMethod, parameters: [String : Any]? = nil, headers: [String : String]? = nil, completionHandler: @escaping (ApiResult<[T]>)->Void) {
        let task = self.request(
            url: url,
            method: method,
            parameters: parameters,
            headers: headers,
            completionHandler: { response in
                switch response {
                case .success(let json):
                    completionHandler(self.mapObjects(T.self, from: json))
                case .failure(let error):
                    completionHandler(ApiResult<[T]>.failure(error))
                }
        })
        task.resume()
    }
    
}


// MARK: - Error Handler

private extension APIRequest {
    
    private func errorFrom(error: Any?, httpStatusCode: Int?) -> ApiError {
        if let error = error as? NSError, error.code == NSURLErrorTimedOut {
            return .noConnection
        }
        guard let httpStatusCode = httpStatusCode else {
            return ApiError.unknown
        }
        return errorFrom(httpStatuscode: httpStatusCode)
    }
    
    
    private func errorFrom(dataResponse response: DataResponse<Any>) -> ApiError {
        return errorFrom(error: response.result.error, httpStatusCode: response.response?.statusCode)
    }
    
    private func errorFrom(httpStatuscode statusCode: Int) -> ApiError {
        switch(statusCode) {
        case 403, 401:
            return  ApiError.unauthorized
        case 400, 404, 500:
            return ApiError.badRequest
        default:
            return ApiError.unknown
        }
    }
}



