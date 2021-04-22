//
//  GetUrlOperation.swift
//  VKClient
//
//  Created by Maksim Savin on 12.04.2021.
//

import Foundation


enum ApiMethods: String {
    case getGroups =  "/method/groups.search"
    case getFriends = "/method/friends.get"
}
//MARK пока без операций
class GetUrlOperation {
    
    let vAPI = "5.145"
    //Фукция создания шаблона URL
    func createApiUrlTemplate(for userID: Int, method: ApiMethods) -> URL {
        var urlApi = URLComponents()
        urlApi.scheme = "https"
        urlApi.host = "api.vk.com"
        urlApi.path = method.rawValue
        urlApi.queryItems = [
            URLQueryItem(name: "owner_id", value: String(userID)),
            URLQueryItem(name: "access_token", value: Session.startSession.token),
            URLQueryItem(name: "v", value: vAPI)
        ]
        switch method{
        case .getGroups:

            urlApi.queryItems?.insert(URLQueryItem(name: "fields", value: "photo_50 , description"), at: 2)
            urlApi.queryItems?.insert(URLQueryItem(name: "extended", value: "1"), at: 3)
            urlApi.queryItems?.insert(URLQueryItem(name: "count", value: "111"), at: 4)
            return urlApi.url!
        case .getFriends:

            urlApi.queryItems?.insert(URLQueryItem(name: "fields", value: "photo_50"), at: 2)
            return urlApi.url!
        }
        
    }
    
}


