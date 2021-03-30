//
//  UserPhoto.swift
//  VKClient
//
//  Created by Maksim Savin on 28.02.2021.
//

import Foundation
import RealmSwift

struct APIPhotoResponse: Codable {
    var response: UserPhotoResponse
}
struct UserPhotoResponse: Codable {
    var count: Int
    var items: [UserPhoto]
}
class UserPhoto: Object, Codable {
    @objc dynamic var albumId: Int
    @objc dynamic var datePhoto: Int
    @objc dynamic var idPhoto: Int
    @objc dynamic var userId: Int
   // @objc dynamic var sizesPhoto: [PhotoSize]
    @objc dynamic var textPhoto: String
    @objc dynamic var likesPhoto: LikesPhoto?
    @objc dynamic var repostsPhoto: RepostsPhoto?
    dynamic var sizesPhoto: List<PhotoSize> = List<PhotoSize>()
    
    override init(){
        albumId = 0
        datePhoto = 0
        idPhoto = 0
        userId = 0
     //   sizesPhoto = []
        textPhoto = ""
        likesPhoto = LikesPhoto()
        repostsPhoto = RepostsPhoto()
       
    }
    
    enum CodingKeys: String, CodingKey{
        case albumId = "album_id"
        case datePhoto = "date"
        case idPhoto = "id"
        case userId = "owner_id"
        case sizesPhoto = "sizes"
        case textPhoto = "text"
        case likesPhoto = "likes"
        case repostsPhoto = "reposts"
    }
    
    override static func primaryKey() -> String? {
            return "idPhoto"
        }
}

class RepostsPhoto: Object, Codable {
    @objc dynamic var repostsCount: Int
    
    override init(){
        repostsCount = 0
    }
    
    
    enum CodingKeys: String, CodingKey {
        case repostsCount = "count"
    }
}

class PhotoSize: Object, Codable {
    @objc dynamic var heightPhoto: Int
    @objc dynamic var urlPhoto: String
    @objc dynamic var typePhoto: String
    @objc dynamic var photoWidth: Int
    
    override init(){
        heightPhoto = 0
        urlPhoto = ""
        typePhoto = ""
        photoWidth = 0
    }
    
//    override static func primaryKey() -> String? {
//            return "urlPhoto"
//        }
    
    enum CodingKeys: String, CodingKey {
        case heightPhoto = "height"
        case urlPhoto = "url"
        case typePhoto = "type"
        case photoWidth = "width"
    }
}

class LikesPhoto: Object, Codable {
    @objc dynamic var isLiked: Int
    @objc dynamic var likesCount: Int
    
    override init(){
        isLiked = 0
        likesCount = 0
    }
    
    enum CodingKeys: String, CodingKey {
        case isLiked = "user_likes"
        case likesCount = "count"
    }
}
