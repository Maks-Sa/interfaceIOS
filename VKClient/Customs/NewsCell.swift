//
//  NewsCell.swift
//  VKClient
//
//  Created by Maksim Savin on 26.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    var isLiked: Bool = false
    
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var timeNews: UILabel!
    @IBOutlet weak var infoNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commButton: UIButton!
    @IBOutlet weak var commCount: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var shareCount: UILabel!
    @IBOutlet weak var viewButton: UIButton!
    @IBOutlet weak var viewCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(titleNews: String, timeNews: String, infoNews: String, photo: UIImage, isLike: Bool, likeCount: Int, commCount: Int, shareCount: Int, viewCount: Int ){
        self.titleNews.text = titleNews
        self.timeNews.text = timeNews
        self.infoNews.text = infoNews
        self.imageNews.image = photo
        self.setIsLikes(isLiked: isLike)
        self.setLikes(likesCount: likeCount)
        self.setCommCount(commCount: commCount)
        self.setShareCount(shareCount: shareCount)
        self.setViewCount(viewCount: viewCount)
    }
    
    func setLikes(likesCount: Int){
        self.likeCount.text = "\(likesCount)"
    }
    func setIsLikes(isLiked: Bool) {
        self.isLiked = isLiked
        if isLiked {
            likeCount.textColor = .red
            likeButton.tintColor = .red
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    func setCommCount(commCount: Int) {
        
        self.commCount.text = "\(commCount)"
    }
    func setShareCount(shareCount: Int) {
        self.shareCount.text = "\(shareCount)"
    }
    func setViewCount (viewCount: Int) {
        self.viewCount.text = "\(viewCount)"
    }
    
    
    // MARK Доделать анимацию
//    что то сделать с фото
//    изменить на иконка группы/друга, имя
}
