//
//  EnumsApi.swift
//  Coesa
//
//  Created by Romilson Nunes on 12/11/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation

// MARK: - ApiService

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


// MARK: - Requestable

enum RequestableURLError: Error {
    case malformedUrl
}
