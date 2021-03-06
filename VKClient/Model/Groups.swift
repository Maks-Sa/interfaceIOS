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
    
    init(idGroup: Int, nameGroup: String, screenNameGroup: String, avatarURLGroup: String, descrGroup: String) {
        self.idGroup = idGroup
        self.nameGroup = nameGroup
        self.screenNameGroup = screenNameGroup
        self.avatarURLGroup = avatarURLGroup
        self.descrGroup = descrGroup
    }
    override init(){
        idGroup = 0
        nameGroup = ""
        screenNameGroup = ""
        avatarURLGroup = ""
        descrGroup = ""
    }
    
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
