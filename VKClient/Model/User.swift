//
//  AboutUser.swift
//  VKClient
//
//  Created by Maksim Savin on 24.03.2021.
//

import Foundation
import RealmSwift

struct ApiUserResponse: Codable {
    var response: [User]
}

class User: Object, Codable {
    @objc dynamic var userId: Int
    @objc dynamic var firstName: String
    @objc dynamic var lastName: String
    @objc dynamic var screenName: String
    @objc dynamic var sex: Int
    @objc dynamic var avatarUserUrl: String
    @objc dynamic var bDateUser: String
    @objc dynamic var aboutUser: String
    
    override init(){
        userId = 0
        firstName = ""
        lastName = ""
        screenName = ""
        sex = 0
        avatarUserUrl = ""
        bDateUser = ""
        aboutUser = ""
    }
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case screenName = "screen_name"
        case sex
        case avatarUserUrl = "photo_50"
        case bDateUser = "bdate"
        case aboutUser = "about"
    }
    
    override static func primaryKey() -> String? {
            return "userId"
        }
}

