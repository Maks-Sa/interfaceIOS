//
//  Session.swift
//  VKClient
//
//  Created by Maksim Savin on 29.01.2021.
//

import Foundation

class Session {
    static let startSession = Session()
    private init() {}
    var token: String?
    var userID: Int?
    
  
}
