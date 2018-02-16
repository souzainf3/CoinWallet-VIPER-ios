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

class ApiHTTPRequest {
    private let manager = Alamofire.SessionManager.default
}


// MARK: - Requests

extension ApiHTTPRequest {
    
    func requestObject<T: Requestable>(request: T, completion: @escaping (ApiResult<T.ResponseType>)->Void) where T.ResponseType: Mappable {
        let task = self.manager.request(request).validate(statusCode: 200..<300).responseJSON(options:.allowFragments) { response in

            switch response.result {
            case .success:
                guard let data = response.result.value else {
                    return completion(ApiResult<T.ResponseType>.failure(.typeMismatch))
                }
                // Data Serialization
                completion(request.mapObject(json: data))
                
            case .failure:
                let error = self.errorFrom(dataResponse: response)
                completion(ApiResult<T.ResponseType>.failure(error))
            }
        }
        
        task.resume()
    }
    
    
    func requestObjects<T: Requestable>(request: T, completion: @escaping (ApiResult<[T.ResponseType]>)->Void) where T.ResponseType: Mappable {

        let task = self.manager.request(request).validate(statusCode: 200..<300).responseJSON(options:.allowFragments) { response in
            
            switch response.result {
            case .success:
                guard let data = response.result.value else {
                    return completion(ApiResult<[T.ResponseType]>.failure(.typeMismatch))
                }
                // Data Serialization
                let mapObjects = request.mapArray(json: data as AnyObject)
                completion(mapObjects)
                
            case .failure:
                let error = self.errorFrom(dataResponse: response)
                completion(ApiResult<[T.ResponseType]>.failure(error))
            }
        }
        
        task.resume()
    }
}


// MARK: - Error Handler

private extension ApiHTTPRequest {
    
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



