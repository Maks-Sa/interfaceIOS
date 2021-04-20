//
//  PromiseNetwork.swift
//  VKClient
//
//  Created by Maksim Savin on 18.04.2021.
//
//Promise Alamofire


import Foundation
import UIKit
import Alamofire
import PromiseKit

enum FriendsError: Error {
    case friendsNotFound(message: String)
}

class PromiseNetwork {
    let vAPI = "5.145"
    let urlFriends = GetUrlOperation()
    let session = URLSession(configuration: URLSessionConfiguration.default)
    let decoder = JSONDecoder()
    
    func getFriendsPromise(for userID: Int) -> Promise<Data> {
        let url = urlFriends.createApiUrlTemplate(for: userID, method: .getFriends)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let promise = Promise<Data> { resolver in
            let task = try? session.dataTask(with: url) { (data, response, error) in
                if data != nil && error == nil {
                    resolver.fulfill(data!)
                } else {
                    resolver.reject(error!)
                }
                
            }
            task!.resume()
            
        }
        return promise
    }
    
    func friendsPromiseParser(with data: Data) -> Promise<[Friend]> {
        let promise = Promise<[Friend]> { resolver in
            let friends = try? decoder.decode(APIFriendResponse.self, from: data).response.items
            guard friends != nil else { return}
            resolver.fulfill(friends!)
        }
        return promise
    }
    
    //    func getFriendsPromise1(for userID: Int) -> Promise<[Friend]> {
    //        let url = urlFriends.createApiUrlTemplate(for: userID, method: .getFriends)
    //            let promise = Promise<[Friend]> { resolver in
    //                let task = try? session.dataTask(with: url) { [weak self] (data, response, error) in
    //                    if data != nil && error == nil {
    //                        let friends = try? self!.decoder.decode(APIFriendResponse.self, from: data!).response.items
    //                        guard friends != nil else {return}
    //                        resolver.fulfill(friends!)
    //                    } else {
    //                        resolver.reject(error!)
    //                    }
    //
    //                }
    //                task!.resume()
    //            }
    //        return promise
    //    }
    
}


