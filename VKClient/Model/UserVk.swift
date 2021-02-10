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
//class userVK {
//    let name : String
//    let surname: String
//    let avatar : UIImage
//    let photo : [UIImage]
//    let gender : gender
//    let idGroup : Int
//    let city: String
//    init(name: String, surname: String, avatar : UIImage, photo : [UIImage], gender: gender, idGroup : Int, city: String) {
//        self.name = name
//        self.surname = surname
//        self.avatar = avatar
//        self.photo = photo
//        self.gender = gender
//        self.idGroup = idGroup
//        self.city = city
//    }
//    init(){
//        self.name = ""
//        self.surname = ""
//        self.avatar = UIImage()
//        self.photo = [UIImage()]
//        self.gender = .male
//        self.idGroup = 0
//        self.city = ""
//    }
//
//
//}


class UserVK {
    let id: Int = 0
    let name: String
    let surname: String
    let avatar: UIImage
    var photo: [PhotoAlbum]?
    let gender: gender
    let idGroup: Int
    let city: String
    init(name: String, surname: String, avatar : UIImage, photo : [PhotoAlbum], gender: gender, idGroup : Int, city: String) {
        self.name = name
        self.surname = surname
        self.avatar = avatar
        self.photo = photo
        self.gender = gender
        self.idGroup = idGroup
        self.city = city
    }
    init(){
        self.name = ""
        self.surname = ""
        self.avatar = UIImage()
        self.photo = [PhotoAlbum()]
        self.gender = .male
        self.idGroup = 0
        self.city = ""
        
    }
}
struct PhotoAlbum{
    var photo: UIImage?

    var isLiked: Bool = false
    var totalCount: Int = Int.random(in: 0..<999)
    


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
