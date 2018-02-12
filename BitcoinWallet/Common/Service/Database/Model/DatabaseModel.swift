//
//  BaseModel.swift
//
//  Created by Romilson Nunes on 24/01/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation
import Realm
import RealmSwift


extension DatabaseManager {
    class BaseModel: Object {
        
        // MARK: Initializers
        
        required public init(value: Any, schema: RLMSchema) {
            super.init(value: value, schema: schema)
        }
        
        required public init(realm: RLMRealm, schema: RLMObjectSchema) {
            super.init(realm: realm, schema: schema)
        }
        
        required public init() {
            super.init()
        }
    }
}

