//
//  UserVk.swift
//  VKClient
//
//  Created by Maksim Savin on 16.12.2020.
//

import UIKit
enum gender {
   case male, female
}
class userVK {
    let name : String
    let sername: String
    let avatar : UIImage
    let photo : [UIImage]
    let gender : gender
    let idGroup : Int
    let city: String
    init(name: String, sername: String, avatar : UIImage, photo : [UIImage], gender: gender, idGroup : Int, city: String) {
        self.name = name
        self .sername = sername
        self.avatar = avatar
        self.photo = photo
        self.gender = gender
        self.idGroup = idGroup
        self.city = city
    }
    
    
}

/*
extension userVK: Equatable {}
func ==(lhs: userVK, rhs: userVK) -> Bool {
    let areEqual = lhs.name == rhs.name &&
        lhs.sername == rhs.sername &&
        lhs.avatar.isEqual(rhs.avatar) &&
        lhs.photo.isEqual(rhs.photo) &&
        lhs.gender == rhs.gender &&
        lhs.idGroup == rhs.idGroup &&
        lhs.city == rhs.city
    
    return areEqual

}
*/
