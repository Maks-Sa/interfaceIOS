//
//  Database.swift
//  VKClient
//
//  Created by Maksim Savin on 03.03.2021.
//

import Foundation
import RealmSwift

class Database {
    private var db: Realm?
    
    init() {
        db = try? Realm()
        print(db?.configuration.fileURL)
    }
}
