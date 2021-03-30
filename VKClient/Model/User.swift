//
//  User.swift
//  VKClient
//
//  Created by Maksim Savin on 03.03.2021.
//

import Foundation
import RealmSwift


struct APIUserResponse: Codable {
    var response: UserResponse
    
}
struct UserResponse: Codable{
    var count: Int
    var items: [User]
}

class User: Object, Codable {
    @objc dynamic var id: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var avatarURL: String
//    @objc dynamic var city: City?
    
    override init(){
        id = 0
        firstName = ""
        lastName = ""
        avatarURL = ""
//        city = City()
    }

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_50"
//        case city
      //  case deactivated
    }
    
    override static func primaryKey() -> String? {
            return "id"
        }
}
//class City: Object, Codable {
//    @objc dynamic var idCity: Int
//    @objc dynamic var titleCity: String
//
//    override init(){
//        idCity = 0
//        titleCity = ""
//    }
//    enum CodingKeys: String, CodingKey {
//        case idCity = "id"
//        case titleCity = "title"
//    }
//}

//MARK добавить City, как парсить если city нет иногда
