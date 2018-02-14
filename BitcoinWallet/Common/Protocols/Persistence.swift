//
//  Persistence.swift
//  BitcoinWallet
//
//  Created by Romilson Nunes on 12/02/18.
//  Copyright © 2018 Romilson Nunes. All rights reserved.
//

import Foundation
import RealmSwift

/* Object Storable */
public protocol Storable {
}
extension Object: Storable {
}


/* Query options */
public struct Sorted {
    var key: String
    var ascending: Bool = true
}


/* Storage config options */
public enum ConfigurationType {
    case standard
    case inMemory(identifier: String)
}



protocol StorageContext {
    
    // Used to notify database changes
    var storageContextNotification: (()->Void)? { get set }
    
    init(configuration: ConfigurationType)
    
    func salve(object: Storable, update: Bool) throws
    func save(objects: [Storable], update: Bool) throws
    func delete(object: Storable) throws
    func delete(objects: [Storable]) throws
    func deleteAll<T: Storable>(_ model: T.Type) throws
    
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate?, sorted: Sorted?) -> [T]

    func clearData()
    static func dropDatabase()
}


