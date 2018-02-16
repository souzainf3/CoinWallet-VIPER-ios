//
//  Mapper.swift
//  Coesa
//
//  Created by Romilson Nunes on 12/11/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation
import ObjectMapper


extension Requestable where ResponseType: Mappable {
        
    func mapObject(json: Any) -> ApiResult<ResponseType> {
        print(ResponseType.self)
        guard let result = Mapper<ResponseType>().map(JSONObject: json) else {
            return .failure(ApiError.typeMismatch)
        }
        return .success(result)
    }
    
    func mapArray(json: Any) -> ApiResult<[ResponseType]> {
        print(ResponseType.self)
        guard let result = Mapper<ResponseType>().mapArray(JSONObject: json) else {
            return .failure(ApiError.typeMismatch)
        }
        return .success(result)
    }
    
}
