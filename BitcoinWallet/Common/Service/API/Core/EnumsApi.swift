//
//  EnumsApi.swift
//  Coesa
//
//  Created by Romilson Nunes on 12/11/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation
import ObjectMapper


// MARK: - Result

enum ApiResult<T> {
    case success(T)
    case failure(ApiError)
}

enum ApiError: Error {
    case unauthorized   // 401
    case noConnection   // Timeout | offline
    case badRequest     // 400, 500, ...
    case typeMismatch   // data serialization
    case unknown        // ?
}


// MARK: - Base Model

class APIBaseModel: Mappable {
    
    // MARK: Initializers
    
    init() {}
    
    required init?(map: Map){
        mapping(map: map)
    }
    
    // MARK: Mappable Protocol
    
    func mapping(map: Map) {}
    
    // MARK: - Date Transform
    func dateTransform() -> DateFormatterTransform {
        return self.dateTransform(format: "yyyy-MM-dd'T'HH:mm:ss'Z'")
    }
    
    final func dateTransform(format: String) -> DateFormatterTransform {
        return CustomDateFormatTransform(formatString: format)
    }
}
