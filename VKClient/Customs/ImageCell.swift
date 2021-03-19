//
//  ImageCell.swift
//  VKClient
//
//  Created by Maksim Savin on 19.01.2021.
//

import UIKit

 class ImageCell: UICollectionViewCell {
    
    var userPhoto = UserPhoto()
 //   var userVK: UserVK?
    var indexCell: Int?
    var isLiked: Int = 0
    var counter: Int = 0

    @IBOutlet weak var photoFriend: UIImageView!
    
    @IBOutlet weak var buttonLike: UIButton!{
        didSet {
            buttonLike.tintColor = .systemGray
            buttonLike.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
  
    @IBOutlet weak var labelLike: UILabel!{
        didSet{
            labelLike.textColor = .systemGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonLike.addTarget(self, action: #selector(setLike), for: .touchUpInside)
        
//        self.layer .borderWidth = 2
//        self.layer.borderColor = UIColor.darkGray.cgColor
    }

    func setData(photo: UIImage, isLike: Int, likesCount: Int){
        self.photoFriend.image = photo
        self.setLikes(count: likesCount)
        self.setIsLiked(int: isLike)
    }

    func setLikes (count: Int) {
        self.labelLike.text = "\(count)"
        counter = count
    }
    
    func setIsLiked (int isLiked: Int) {
        self.isLiked = isLiked
        if isLiked == 1 {
            labelLike.textColor = .red
            buttonLike.tintColor = .red
            buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
            
        @objc func setLike() {
            if isLiked == 0 {
                counter = counter + 1
                labelLike.textColor = .red
                buttonLike.tintColor = .red
                buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
            else  {
                counter = counter - 1
                labelLike.textColor = .systemGray
                buttonLike.tintColor = .systemGray
                buttonLike.setImage(UIImage(systemName: "heart"), for: .normal)
            }
            animateLike()
            labelLike.text = "\(counter)"
            userPhoto.likesPhoto!.likesCount = counter
            (userPhoto.likesPhoto!.isLiked == 0) ? (userPhoto.likesPhoto!.isLiked = 1) : (userPhoto.likesPhoto!.isLiked = 0)
            (isLiked == 0) ? (isLiked = 1) : (isLiked = 0)
            //isLiked.toggle()
        }
    func animateLike () {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = transform.self
        scaleAnimation.toValue = 0.8
        scaleAnimation.duration = 0.15
        scaleAnimation.autoreverses = true
        buttonLike.layer.add(scaleAnimation, forKey: nil)
        labelLike.layer.add(scaleAnimation, forKey: nil)
        
    }
    

    
    

    
}
