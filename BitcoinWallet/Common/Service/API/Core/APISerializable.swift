//
//  Mapper.swift
//  Coesa
//
//  Created by Romilson Nunes on 12/11/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation
import ObjectMapper

protocol ApiResultSerializable {
    func mapObject<T: Mappable>(_: T.Type, from json: Any?) -> ApiResult<T>
    func mapObjects<T: Mappable>(_: T.Type, from json: Any?) -> ApiResult<[T]>
}

extension ApiResultSerializable {
    
    func mapObject<T: Mappable>(_: T.Type, from json: Any?) -> ApiResult<T> {
        guard let result = Mapper<T>().map(JSONObject: json) else {
            return .failure(ApiError.typeMismatch)
        }
        return .success(result)
    }

    func mapObjects<T: Mappable>(_: T.Type, from json: Any?) -> ApiResult<[T]> {
        guard let result = Mapper<T>().mapArray(JSONObject: json) else {
            return .failure(ApiError.typeMismatch)
        }
        return .success(result)
    }
}

