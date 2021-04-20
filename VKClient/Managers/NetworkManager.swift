//
//  Network.swift
//  VKClient
//
//  Created by Maksim Savin on 09.02.2021.
//


import Foundation
import UIKit

class NetworkManager {
    //  let user1: User = User()
    public struct NewsFeedType: RawRepresentable {
        public static let post = NewsFeedType(rawValue: "post")
        public static let photo = NewsFeedType(rawValue: "photo")
        
        public let rawValue: String
        
        public init(rawValue: String) {
            self.rawValue = rawValue
        }
    }
    let vAPI = "5.145"
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    //Получение списка друзей
    func getUserFriends (for userID: Int, handler: @escaping ([Friend]) -> Void ) {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(userID)),
            URLQueryItem(name: "fields", value: "photo_50"),
            //            URLQueryItem(name: "fields", value: "city"),
            //   URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vAPI)
        ]
        guard let url = urlComponents.url else {return}
        
        //        print(url)
        //создаем сессию
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let decoder = JSONDecoder()
        let task = session.dataTask(with: url) { (data, response, error) in
            if data != nil && error == nil {
                let friendResponse = try? decoder.decode(APIFriendResponse.self, from: data!).response.items
                //     print("userResponse?.items.count \(userResponse?.items.count)")
                DispatchQueue.main.async {
                    try? Database.save(items: friendResponse!)
                }
                if friendResponse != nil {
                    handler(friendResponse!)
                } else {
                    print("Json parse error")
                }
            } else {
                print("Network error")
            }
        }
        task.resume()
    }
    
    func getImage(by urlStr: String, handler: @escaping ((UIImage) -> Void)) {
        guard let url = URL(string: urlStr) else {return}
        if let imageFromCache = imageCache.object(forKey: url as AnyObject) as? UIImage {
            handler(imageFromCache)
        }
        if let data = try? Data(contentsOf: url){
            let image = UIImage(data: data)
            imageCache.setObject(image!, forKey: url as AnyObject)
            handler(image!)
        }
    }
    
    //Получение фотографий пользователя
    
    func getUserPhoto(for userID: Int, handler: @escaping ([UserPhoto]) -> Void) {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: String(userID)),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "100"),
            // URLQueryItem(name: "no_service_albums", value: "1"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vAPI)
        ]
        guard let url = urlComponents.url else {return}
        //        print(url)
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let decoder = JSONDecoder()
        let task = session.dataTask(with: url) {(data, response, error) in
            if data != nil && error == nil {
                let photoResponse = try? decoder.decode(APIPhotoResponse.self, from: data!).response.items
                DispatchQueue.main.async {
                    try? Database.save(items: photoResponse!)
                }
                if photoResponse != nil {
                    //                  dump("count sizes= \(photoResponse![0].sizesPhoto.count)")
                    //                    dump("url from Network= \(photoResponse![0].sizesPhoto[0].urlPhoto)")
                    //                  dump("all from network = \(photoResponse)")
                    handler(photoResponse!)
                } else {
                    print("JSON parse error")
                }
            } else {
                print("Network error")
            }
        }
        task.resume()
    }
    
    
    
    // Получение групп текущего пользователя
    func getGroups(for userID: Int, handler: @escaping ([Groups]) -> Void) {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "owner_id", value: String(userID)),
            URLQueryItem(name: "fields", value: "photo_50"),
            URLQueryItem(name: "fields", value: "description"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "111"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vAPI)
        ]
        guard let url = urlComponents.url else {return}
        //        print(url)
        
        //создаем сессию
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let decoder = JSONDecoder()
        //создаем задание
        let task = session.dataTask(with: url) {(data, response, error) in
            if data != nil && error == nil {
                let groupResponse = try? decoder.decode(APIGroupsResponce.self, from: data!).response.items
                DispatchQueue.main.async {
                    try? Database.save(items: groupResponse!)
                }
                if groupResponse != nil {
                    //                    dump("all groups from network = \(groupResponse)")
                    handler(groupResponse!)
                }else {
                    print("JSON parse error.")
                }
            } else {
                print("Network error")
            }
        }
        task.resume()
    }
    
    
    
    //Получение групп по поисковому запросу
    func searchGroup(request: String, handler: @escaping ([SrchGroups]) -> Void) {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: request),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "sort", value: "0"),
            //            URLQueryItem(name: "count", value: "3"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vAPI)
        ]
        guard let url = urlComponents.url else {return}
        //        print(url)
        //создаем сессию
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let decoder = JSONDecoder()
        //создаем задание
        let task = session.dataTask(with: url) {(data, response, error) in
            if data != nil && error == nil {
                let searchGroups = try? decoder.decode(APISrchGroupsResponce.self, from: data!).response.items
                // print("Поиск групп1  -\(searchGroups)")
                if searchGroups != nil {
                    handler(searchGroups!)
                }else {
                    print("JSON parse error. Search Group")
                }
            } else {
                print("Network error")
            }
        }
        task.resume()
    }
    
    
    //Получение данных для профиля пользователя
    func getUserProfile(for userID: Int, handler: @escaping ([User]) -> Void){
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/users.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "users_ids", value: String(userID)),
            URLQueryItem(name: "fields", value: "photo_50, photo_50, about, bdate, sex, screen_name"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vAPI)
        ]
        guard let url = urlComponents.url else {return}
        print(url)
        //создаем сессию
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let decoder = JSONDecoder()
        let task = session.dataTask(with: url) { (data, response, error) in
            if data != nil && error == nil {
                let userResponse = try? decoder.decode(ApiUserResponse.self, from: data!).response
                DispatchQueue.main.async {
                    try? Database.save(items: userResponse!)
                }
                if userResponse != nil {
                    handler(userResponse!)
                } else {
                    print("Json parse error")
                }
            } else {
                print("Network error")
            }
        }
        task.resume()
    }
    
    //Получение данных для новостей
    // Тип post
    func getNewsFeed(type: NewsFeedType, handler: @escaping ([NewsPost]) ->()) {
        let dispatchGroup = DispatchGroup()
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/newsfeed.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "filters", value: type.rawValue),
            URLQueryItem(name: "count", value: "100"),
            URLQueryItem(name: "max_photos", value: "4"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vAPI)
        ]
        guard let url = urlComponents.url else {return}
        print(url)
        //создаем сессию
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let decoder = JSONDecoder()
        //создаем задание
        let task = session.dataTask(with: url) { (data, _, _) in
            if let data = data {
                do {
                    let newsPosts = try decoder.decode(NewsPostResponse.self, from: data).items
                    let groups = try decoder.decode(NewsPostResponse.self, from: data).gpoups
                    let profiles = try decoder.decode(NewsPostResponse.self, from: data).profiles
              
                    DispatchQueue.global().async(group: dispatchGroup) {
                        newsPosts.forEach { news in
                            if news.sourceId < 0 {
                                //groups
                                let group =  groups.first { (element) -> Bool in
                                    element.id == abs(news.sourceId)
                                }
                                news.name = group?.name ?? "Group name"
                                news.avatarUrl = group?.photoURL ?? "https://vk.com/images/camera_50.png"
                            } else {
                                //profiles
                                let profile =  profiles.first { (element) -> Bool in
                                    element.id == abs(news.sourceId)
                                }
                                news.name = profile?.name ?? "Profile name"
                                news.avatarUrl = profile?.photoURL ?? "https://vk.com/images/camera_50.png"
                            }
                        }
                    }
                    handler(newsPosts)
                }
                catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
        
   
    // MARK реализовать
// получение новостей тип photo
//    стена пользователя  wall.get
    
    
       
    


