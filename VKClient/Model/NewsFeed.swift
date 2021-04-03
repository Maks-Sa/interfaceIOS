//
//  NewsFeed.swift
//  VKClient
//
//  Created by Maksim Savin on 28.03.2021.


import Foundation
import UIKit


struct NewsPostResponse: Decodable {
    let items: [NewsPost]
    let profiles: [NewsPostProfiles]
    let gpoups: [NewsPostGroups]
    let nextFrom: String?
    
    enum ResponseCodingKeys: String, CodingKey {
        case response
        case items
        case profiles
        case groups
        case nextFrom = "next_from"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ResponseCodingKeys.self)
        let response = try container.nestedContainer(keyedBy: ResponseCodingKeys.self, forKey: .response)
        self.items = try response.decode([NewsPost].self, forKey: .items)
        self.profiles = try response.decode([NewsPostProfiles].self, forKey: .profiles)
        self.gpoups = try response.decode([NewsPostGroups].self, forKey: .groups)
        self.nextFrom = try? response.decode(String.self, forKey: .nextFrom)
    }
}

struct NewsPostProfiles: Decodable {
    var id = 0
    var name = ""
    var photoURL = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case photoURL = "photo_50"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id =  try container.decode(Int.self, forKey: .id)
        let lastName = try container.decode(String.self, forKey: .lastName)
        let firstName = try container.decode(String.self, forKey: .firstName)
        self.name = "\(lastName) \(firstName)"
        self.photoURL = try container.decode(String.self, forKey: .photoURL)
    }
}

struct NewsPostGroups: Decodable {
    var id = 0
    var name = ""
    var photoURL = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case photoURL = "photo_50"
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id =  try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.photoURL = try container.decode(String.self, forKey: .photoURL)
    }
    
}


struct NewsPostAttachment: Decodable {
    var type = ""
    var url = ""
    var ratio: CGFloat = 0
    
    enum CodingKeys: String, CodingKey {
        case type
        case photo
        case sizes
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey: .type)
        if self.type == "photo" {
            let photoContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .photo)
            let sizesArray = try photoContainer.decode([PhotoSize].self, forKey: .sizes)
            let maxSize = sizesArray.first(where: {$0.typePhoto == "x"}) ?? sizesArray[0]
            
            self.url = maxSize.urlPhoto
            self.ratio = CGFloat( maxSize.photoWidth) / CGFloat( maxSize.heightPhoto)
        }
        if self.type == "video" {
            self.url = "https://i.pinimg.com/originals/55/93/f2/5593f24a1396ef54f74aab8bb595c1aa.jpg"
            self.ratio = CGFloat( 1240.0 / 711.0 )
        }
        
        if self.type == "link" {
            self.url = "http://blog.doubletrade.ru/wp-content/uploads/2013/05/linkutili.jpg"
            self.ratio = CGFloat( 720.0 / 540.0)
        }
        if self.type == "doc" {
            self.url = "https://taxiklass.ru/wp-content/uploads/2019/06/kak-najti-okpo-i-kpp-organizatsii-po-eyo-inn.png"
            self.ratio = CGFloat( 1240.0 / 711.0 )
        }
        if self.type == "posted_photo" || self.type == "audio" || self.type == "graffiti" || self.type == "note" || self.type == "app" || self.type == "poll" || self.type == "page" || self.type == "album" || self.type == "photos_list" || self.type == "market" || self.type == "market_album" || self.type == "sticker" || self.type == "pretty_cards" || self.type == "event" {
            self.url = "https://i.pinimg.com/originals/91/b7/cd/91b7cd5596b658e7b428c9157e116a2b.jpg"
//            "https://vsthemes.org/uploads/olives/love920s1/48/0a4845167ff0983aed6a6036c7a6f2f2.jpg"
            self.ratio = CGFloat( 1240.0 / 711.0 )
        }
        
    }
    
}

class NewsPost: Decodable {
    var sourceId = 0
    var name = ""
    var avatarUrl = ""
    var date = 0
    var likesCount = 0
    var isLiked = 0
    var repostsCount = 0
    var viewsCount: Int?
    var commentsCount = 0
    var text = ""
    var attachments : [NewsPostAttachment]?
    
    enum RepostsCodingKeys: String, CodingKey{
        case repostsCount = "count"
    }
    
    enum LikesCodingKeys: String, CodingKey {
        case likesCount = "count"
        case isLiked = "user_likes"
    }
    
    enum ViewsCodingKeys: String, CodingKey {
        case viewsCount = "count"
    }
    
    enum CommentsCodingKeys: String, CodingKey {
        case commentsCount = "count"
    }
    
    enum AttachmentsCodingKeys: String, CodingKey {
        case attType = "type"
    }
    
    enum CodingKeys: String, CodingKey {
        case sourceId = "source_id"
        case date
        case text
        case likes
        case reposts
        case views
        case comments
        case attachments
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.date = try container.decode(Int.self, forKey: .date)
        self.text = try container.decode(String.self, forKey: .text)
        self.sourceId = try container.decode(Int.self, forKey: .sourceId)

        let likeContainer = try container.nestedContainer(keyedBy: LikesCodingKeys.self, forKey: .likes)
        self.isLiked = try likeContainer.decode(Int.self, forKey: .isLiked)
        self.likesCount = try likeContainer.decode(Int.self, forKey: .likesCount)
        
        let repostsContainer = try container.nestedContainer(keyedBy: RepostsCodingKeys.self, forKey: .reposts)
        self.repostsCount = try repostsContainer.decode(Int.self, forKey: .repostsCount)
        
        let viewsContainer = try? container.nestedContainer(keyedBy: ViewsCodingKeys.self, forKey: .views)
        self.viewsCount = try? viewsContainer?.decode(Int.self, forKey: .viewsCount)
       
        let commentsContainer = try container.nestedContainer(keyedBy: CommentsCodingKeys.self, forKey: .comments)
        self.commentsCount = try commentsContainer.decode(Int.self, forKey: .commentsCount)
       
        self.attachments = try? container.decode([NewsPostAttachment].self, forKey: .attachments)
    }
    
}
