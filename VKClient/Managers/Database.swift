//
//  Database.swift
//  VKClient
//
//  Created by Maksim Savin on 03.03.2021.
//

import Foundation
import RealmSwift

class Database {
    
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
        return realm.objects(T.self)
        
    }
}


//class Database {
//    private var db: Realm?
//    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
//
//    init() {
//        db = try? Realm()
//        print(db?.configuration.fileURL)
//    }
//    func write <T: Object> (items: [T],
//                            configuration: Realm.Configuration = deleteIfMigration,
//                            update: Realm.UpdatePolicy = .modified) throws {
//
//        }
//
//    func read() {
//
//    }
//}
