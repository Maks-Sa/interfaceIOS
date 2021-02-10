//
//  Network.swift
//  VKClient
//
//  Created by Maksim Savin on 09.02.2021.
//


/*
 Реализовать запросы к VK API:
 Получение списка друзей
 Получение фотографий человека
 Получение групп текущего пользователя
 Получение групп по поисковому запросу
 Вывести данные в консоль.

 */
import Foundation

class NetworkVK {
    
    let vkAPI = "5.126"
//Получение списка друзей
    func getUserFriends () {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/friends.get"
        urlComponents.queryItems = [
            URLQueryItem(name: "fields", value: "photo_100"),
            URLQueryItem(name: "count", value: "10"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vkAPI)
        ]
        //создаем сессию
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //создаем задание
        let task = session.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print("Список друзей - \(String(data: data, encoding: .utf8)!)")
        }
        task.resume()
    }
    
    //Получение фотографий человека
    func getPhotos(userID: String) {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/photos.getAll"
        urlComponents.queryItems = [
          //  URLQueryItem(name: "owner_id", value: String(user.id)),
            URLQueryItem(name: "owner_id", value: userID),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "no_service_albums", value: "1"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vkAPI)
        ]
        //создаем сессию
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //создаем задание
        let task = session.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print("Фотографии пользователя - \(String(data: data, encoding: .utf8)!)")
        }
        task.resume()
    }
    
    //Получение групп текущего пользователя
    func getGroups(user: String) {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.get"
        urlComponents.queryItems = [
            //URLQueryItem(name: "owner_id", value: String(user.id)),
            URLQueryItem(name: "owner_id", value: user),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "fields", value: "city"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vkAPI)
        ]
        //создаем сессию
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //создаем задание
        let task = session.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print("Группы пользователя - \(String(data: data, encoding: .utf8)!)")
        }
        task.resume()
    }
    
    //Получение групп по поисковому запросу
    func searchGroup(request: String) {
        //собираем  URL
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.vk.com"
        urlComponents.path = "/method/groups.search"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: request),
            URLQueryItem(name: "type", value: "group"),
            URLQueryItem(name: "sort", value: "0"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vkAPI)
        ]
        //создаем сессию
        let request = URLRequest(url: urlComponents.url!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //создаем задание
        let task = session.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print("Поиск групп - \(String(data: data, encoding: .utf8)!)")
        }
        task.resume()
    }
    
    //MARK доделать
    func startSession (by request: URLRequest) {
        //создаем сессию
        let session = URLSession(configuration: URLSessionConfiguration.default)
        //создаем задание
        let task = session.dataTask(with: request) {(data, response, error) in
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8)!)
        }
        task.resume()
        
    }
    
}

