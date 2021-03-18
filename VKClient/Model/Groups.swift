//
//  Groups.swift
//  VKClient
//
//  Created by Maksim Savin on 02.03.2021.
//

import Foundation
import RealmSwift


struct APIGroupsResponce: Codable {
    let response: GroupsResponse
}

struct GroupsResponse: Codable {
    let count: Int
    let items: [Groups]
}

class Groups: Object, Codable{
    @objc dynamic var idGroup: Int
    @objc dynamic var nameGroup: String
    @objc dynamic var screenNameGroup: String
    @objc dynamic var avatarURLGroup: String
    @objc dynamic var descrGroup: String
    
    enum CodingKeys: String, CodingKey {
        case idGroup = "id"
        case nameGroup = "name"
        case screenNameGroup = "screen_name"
        case avatarURLGroup = "photo_50"
        case descrGroup = "description"
    }
    
    override static func primaryKey() -> String? {
            return "idGroup"
        }

}
