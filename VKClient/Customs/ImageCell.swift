//
//  ImageCell.swift
//  VKClient
//
//  Created by Maksim Savin on 19.01.2021.
//

import UIKit

 class ImageCell: UICollectionViewCell {
    
    var userVK: UserVK?
    var indexCell: Int?
    var isLiked: Bool = false
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

    func setData(photo: UIImage, isLike: Bool, likeCount: Int){
        self.photoFriend.image = photo
        self.setLikes(count: likeCount)
        self.setIsLiked(bool: isLike)
    }

    func setLikes (count: Int) {
        self.labelLike.text = "\(count)"
        counter = count
    }
    
    func setIsLiked (bool isLiked: Bool) {
        self.isLiked = isLiked
        if isLiked {
            labelLike.textColor = .red
            buttonLike.tintColor = .red
            buttonLike.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
            
        @objc func setLike() {
            if !isLiked  {
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
            userVK?.photo![indexCell!].totalCount = counter
            userVK?.photo![indexCell!].isLiked.toggle()
            isLiked.toggle()
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
