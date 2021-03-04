//
//  GroupsVk.swift
//  VKClient
//
//  Created by Maksim Savin on 16.12.2020.
//


//Старое, пока оставить
import UIKit
// класс для групп

class groups {
    var id: Int = 0
    var name: String = ""
    var photo_50_URL: String = ""
    var description: String = ""
}

class groupsVK {
    let nameGroup: String
    let iconGroup: UIImage
    let infoGroup: String

    init(nameGroup: String, iconGroup: UIImage, infoGroup: String) {
        self.nameGroup = nameGroup
        self.iconGroup = iconGroup
        self.infoGroup = infoGroup
  
    }
    
    
}


extension groupsVK: Equatable {}
func ==(lhs: groupsVK, rhs: groupsVK) -> Bool {
    let areEqual = lhs.nameGroup == rhs.nameGroup &&
        lhs.infoGroup == rhs.infoGroup &&
        lhs.iconGroup.isEqual(rhs.iconGroup)
    return areEqual
    
}

