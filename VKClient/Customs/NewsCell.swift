//
//  NewsCell.swift
//  VKClient
//
//  Created by Maksim Savin on 26.01.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    var isLiked: Bool = false
    var news: News?
    var indexCell: Int = 0
    var counter: Int = 0

    
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var timeNews: UILabel!
    @IBOutlet weak var infoNews: UILabel!
    @IBOutlet weak var imageNews: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
//    {
//        didSet {
//            likeButton.tintColor = .systemGray
//            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
//        }
//    }
    @IBOutlet weak var likeCount: UILabel! {
        didSet {
            likeCount.textColor = .systemGray
        }
    }
    @IBOutlet weak var commButton: UIButton! {
        didSet {
            commButton.tintColor = .systemGray
        }
    }
    @IBOutlet weak var commCount: UILabel! {
        didSet {
            commCount.textColor = .systemGray
        }
    }
    @IBOutlet weak var shareButton: UIButton! {
        didSet {
            shareButton.tintColor = .systemGray
        }
    }
    @IBOutlet weak var shareCount: UILabel! {
        didSet {
            shareCount.textColor = .systemGray
        }
    }
    @IBOutlet weak var viewButton: UIButton!{
        didSet{
            viewButton.tintColor = .systemGray
        }
    }
    @IBOutlet weak var viewCount: UILabel! {
        didSet {
            viewCount.textColor = .systemGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeButton.addTarget(self, action: #selector(setLike), for: .touchUpInside)
                self.layer.borderWidth = 2
                self.layer.borderColor = UIColor.darkGray.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(news: News, indexCell: Int, titleNews: String, timeNews: String, infoNews: String, photo: UIImage, isLike: Bool, likeCount: Int, commCount: Int, shareCount: Int, viewCount: Int ){
        self.news = news
        self.indexCell = indexCell
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
        counter = likesCount
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
    
    @objc func setLike() {
        if !isLiked {
            counter = counter + 1
            likeCount.textColor = .red
            likeButton.tintColor = .red
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            counter = counter - 1
            likeCount.textColor = .systemGray
            likeButton.tintColor = .systemGray
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        animateLike()
        likeCount.text = "\(counter)"
        news?.photo.totalCount = counter
        news?.photo.isLiked.toggle()
        isLiked.toggle()
    }
    
    func animateLike (){
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = transform.self
        scaleAnimation.toValue = 0.8
        scaleAnimation.duration = 0.15
        scaleAnimation.autoreverses = true
        likeButton.layer.add(scaleAnimation, forKey: nil)
        likeCount.layer.add(scaleAnimation, forKey: nil)
    }
    
    // MARK
//    что то сделать с фото
//    изменить на иконка группы/друга, имя
}
