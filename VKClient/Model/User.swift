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
    
    override init(){
        id = 0
        firstName = ""
        lastName = ""
        avatarURL = ""
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarURL = "photo_50"
    }
}
