//
//  News.swift
//  VKClient
//
//  Created by Maksim Savin on 27.01.2021.
//

import UIKit

struct News {
    var icon: UIImage
    var title: String
    var timeNews: String
    var info: String
    var photo: PhotoAlbum
    var commentCount: Int = Int.random(in: 0..<999)
    var share: Int = Int.random(in: 0..<999)
    var view: Int = Int.random(in: 0..<999)
    
}

func dateToString() -> String {
    let today = Date()
    let formatter3 = DateFormatter()
    formatter3.dateFormat = "HH:mm E, d MMM y"
    return(formatter3.string(from: today))
}
