//
//  Database.swift
//  VKClient
//
//  Created by Maksim Savin on 03.03.2021.
//

import Foundation
import RealmSwift

class Database {
   static var token: NotificationToken?
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    
    static func save <T: Object> (items: [T],
                                  configuration: Realm.Configuration = deleteIfMigration,
                                  update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write{
            realm.add(items, update: update)
        }
    }
    
    static func load <T:Object>(typeOF: T.Type) throws -> Results<T> {
        let realm = try Realm()
        let objects = realm.objects(T.self)
        //token = objects.observe(<#T##block: (RealmCollectionChange<Results<T>>) -> Void##(RealmCollectionChange<Results<T>>) -> Void#>)
        return objects
        
    }
    static func delete <T:Object>(object: Results<T>) throws {
        let realm = try Realm()
        try realm.write {
            realm.delete(object)
        }
    }
}


