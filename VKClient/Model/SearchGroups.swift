//
//  SearchGroups.swift
//  VKClient
//
//  Created by Maksim Savin on 19.03.2021.
//

import Foundation
import RealmSwift


struct APISrchGroupsResponce: Codable {
    let response: SrchGroupsResponse
}

struct SrchGroupsResponse: Codable {
    let count: Int
    let items: [SrchGroups]
}

class SrchGroups: Object, Codable{
    @objc dynamic var idGroup: Int
    @objc dynamic var nameGroup: String
    @objc dynamic var screenNameGroup: String
    @objc dynamic var avatarURLGroup: String

    
    override init(){
        idGroup = 0
        nameGroup = ""
        screenNameGroup = ""
        avatarURLGroup = ""

    }
    
    enum CodingKeys: String, CodingKey {
        case idGroup = "id"
        case nameGroup = "name"
        case screenNameGroup = "screen_name"
        case avatarURLGroup = "photo_50"
    }
    
    override static func primaryKey() -> String? {
            return "idGroup"
        }

    func toGroups() -> Groups {
       
        return Groups(idGroup: idGroup,
                      nameGroup: nameGroup,
                      screenNameGroup: screenNameGroup,
                      avatarURLGroup: avatarURLGroup,
                      descrGroup: "")
    }
}

