//
//  PhotoFriendsCell.swift
//  VKClient
//
//  Created by Maksim Savin on 28.12.2020.
//

import UIKit

class PhotoFriendsCell: UICollectionViewCell {

    @IBOutlet weak var photoFriend: UIImageView!
    @IBOutlet weak var LikeControl: LikeControl!
    
    func setData (photo: UIImage) {
        photoFriend.image = photo
    }
}
