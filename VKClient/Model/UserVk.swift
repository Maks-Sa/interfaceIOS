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
    let avatar : UIImage
    let photo : UIImage
    let gender : gender
    let idGroup : Int
    init(name: String, avatar : UIImage, photo : UIImage, gender: gender, idGroup : Int) {
        self.name = name
        self.avatar = avatar
        self.photo = photo
        self.gender = gender
        self.idGroup = idGroup
    }
    
    
}
