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
    let vAPI = "5.130"
    
    private let imageCache = NSCache<AnyObject, AnyObject>()
    
    //Получение списка друзей
    func getUserFriends (for userID: Int, handler: @escaping ([User]) -> Void ) {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "user_id", value: String(userID)),
            URLQueryItem(name: "fields", value: "photo_50"),
            //   URLQueryItem(name: "count", value: "20"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vAPI)
        ]
        guard let url = urlComponents.url else {return}
        
//        print(url)
        //создаем сессию
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let decoder = JSONDecoder()
       // URLSession.shared.dataTask(with: url) { (data, response, error) in
        let task = session.dataTask(with: url) { (data, response, error) in
            if data != nil && error == nil {
                let userResponse = try? decoder.decode(APIUserResponse.self, from: data!).response.items
                //     print("userResponse?.items.count \(userResponse?.items.count)")
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
                    print("JSON parse error")
                }
            } else {
                print("Network error")
            }
        }
        task.resume()
    }
    

// MARK доделать
//    //Получение групп по поисковому запросу
//    func searchGroup(request: String) {
//        //собираем  URL
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "api.vk.com"
//        urlComponents.path = "/method/groups.search"
//        urlComponents.queryItems = [
//            URLQueryItem(name: "q", value: request),
//            URLQueryItem(name: "type", value: "group"),
//            URLQueryItem(name: "sort", value: "0"),
//            URLQueryItem(name: "count", value: "3"),
//            URLQueryItem(name: "access_token", value: Session.startSession.token),
//            URLQueryItem(name: "v", value: vAPI)
//        ]
//        //создаем сессию
//        let request = URLRequest(url: urlComponents.url!)
//        let session = URLSession(configuration: URLSessionConfiguration.default)
//        //создаем задание
//        let task = session.dataTask(with: request) {(data, response, error) in
//            guard let data = data,
//                  let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//            else { return }
//         //   print("Поиск групп - \(String(data: data, encoding: .utf8)!)")
//            let dataString =  String(data: data, encoding: String.Encoding.utf8)
//            print("Поиск групп  -\(json)")
//
//
//        }
//        task.resume()
//    }
    
 
    
}

