//
//  DatabaseManager.swift
//
//  Created by Romilson Nunes on 26/01/17.
//  Copyright © 2017 Romilson Nunes. All rights reserved.
//

import Foundation
import RealmSwift


// MARK: - AccessDatabaseProtocol

protocol RealmDatabaseAccessible {
    
    var realm: Realm { get }
    
    /// Thread safe realm instance
    func safeRealm() -> Realm
}

extension RealmDatabaseAccessible {
    
    func safeRealm() -> Realm {
        let config = realm.configuration
        return try! Realm(configuration: config)
    }
}

class DatabaseManager: RealmDatabaseAccessible {
    
    internal(set) lazy var realm: Realm = {
        DatabaseManager.setRealmConfiguration()
        // Migration granted
        do {
            return try Realm()
        } catch {
            print("Error Init Realm: \(error)")
            DatabaseManager.migrate()
            return try! Realm()
        }
    }()

    
    /// Migrate
    
    // Fix recurrents migrations call
    private static func setRealmConfiguration() {
        let config = Realm.Configuration(schemaVersion: DatabaseManager.currentRealmSchemaVersion())
        Realm.Configuration.defaultConfiguration = config
    }
    
    private static func currentRealmSchemaVersion() -> UInt64 {
        // Try migrate
        do {
            if let url = Realm.Configuration.defaultConfiguration.fileURL {
                let schemaVersion = try schemaVersionAtURL(url)
                return schemaVersion
            }
        } catch {
            return 0
        }
        return 0
    }
    
    private static func migrate() {
        // Try migrate
        do {
            if let url = Realm.Configuration.defaultConfiguration.fileURL {
                let schemaVersion = try schemaVersionAtURL(url)
                migrate(to: schemaVersion + 1) // Increment
            }
        } catch {
            DatabaseManager.dropDatabase()
        }
    }
    
    static func migrate(to newSchemaVersion: UInt64) {
        
        let config =  Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: newSchemaVersion,
            
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { (migration, oldSchemaVersion) in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < newSchemaVersion) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                    print("Realm migration nothing to do.")
                }
                print("Realm migration complete.")
        },
            deleteRealmIfMigrationNeeded: true
        )
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
        // Now that we've told Realm how to handle the schema change, opening the file
        // will automatically perform the migration
        do {
            _ = try Realm()
        } catch let error as NSError {
            print(error)
            DatabaseManager.dropDatabase()
        }
    }
    
}

extension DatabaseManager: Persistence  {
    
    func salve(object: Storable, update: Bool) throws {
        let aRealm = self.safeRealm()
        aRealm.beginWrite()
        aRealm.add(object as! Object, update: update)
        return try aRealm.commitWrite()
    }
    
    func save(objects: [Storable], update: Bool) throws {
        let aRealm = self.safeRealm()
        aRealm.beginWrite()
        aRealm.add(objects as! [Object], update: update)
        return try aRealm.commitWrite()
    }
    
    func delete(object: Storable) throws {
        let aRealm = self.safeRealm()
        aRealm.beginWrite()
        aRealm.delete(object as! Object)
        return try aRealm.commitWrite()
    }
    
    func delete(objects: [Storable]) throws {
        let aRealm = self.safeRealm()
        aRealm.beginWrite()
        aRealm.delete(objects as! [Object])
        return try aRealm.commitWrite()
    }
    
    func deleteAll<T : Storable>(_ model: T.Type) throws {
        let aRealm = self.safeRealm()
        let objects = aRealm.objects(model as! Object.Type)
        for object in objects {
            aRealm.delete(object)
        }
    }
    
    func fetch<T: Storable>(_ model: T.Type, predicate: NSPredicate? = nil, sorted: Sorted? = nil, completion: (([T]) -> ())) {
        let aRealm = self.safeRealm()

        var objects = aRealm.objects(model as! Object.Type)
        
        if let predicate = predicate {
            objects = objects.filter(predicate)
        }
        
        if let sorted = sorted {
            objects = objects.sorted(byKeyPath: sorted.key, ascending: sorted.ascending)
        }
        
        completion(objects.flatMap { $0 as? T })
    }
    
    func clearData() {
        do {
            let aRealm = self.safeRealm()
            try aRealm.write {
                aRealm.deleteAll()
            }
        } catch {}
    }
    
    static func dropDatabase() {
        guard let path = Realm.Configuration.defaultConfiguration.fileURL else {
            return
        }
        
        do {
            try FileManager().removeItem(at: path)
        } catch {
            print(#function + "couldn't remove at path: \(error)")
        }
    }
}



