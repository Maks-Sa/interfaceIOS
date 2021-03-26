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
    @IBOutlet weak var iconNews: IconSettings!
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
//                self.layer.borderWidth = 1
//                self.layer.borderColor = UIColor.darkGray.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(news: News, indexCell: Int, iconNews: UIImage, titleNews: String, timeNews: String, infoNews: String, photo: UIImage, isLike: Bool, likeCount: Int, commCount: Int, shareCount: Int, viewCount: Int ){
        
        self.news = news
        self.indexCell = indexCell
        self.iconNews.imageView.image = iconNews
        self.titleNews.text = titleNews
        self.timeNews.text = timeNews
        self.infoNews.text = infoNews
        self.imageNews.image = photo
        self.setIsLikes(isLiked: isLike)
        self.setLikes(likesCount: likeCount)
        self.setCommCount(commCount: commCount)
        self.setShareCount(shareCount: shareCount)
        self.setViewCount(viewCount: viewCount)
    //    self.imageNews.image = self.resizeImage(image: photo, targetSize: CGSize(width: 50, height: 50))
//        self.imageNews.image = photo.imageResized(to: CGSize(width: 60, height: 50))
//        print(self.imageNews.frame.width)
//        print(self.imageNews.frame.height)
//        print(self.imageNews.image?.size.width)
//        print(self.imageNews.image?.size.height)
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
    
    
    //Mark нужно ли?
//    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
//        let size = image.size
//
//        let widthRatio  = targetSize.width  / size.width
//        let heightRatio = targetSize.height / size.height
//
//        // Figure out what our orientation is, and use that to form the rectangle
//        var newSize: CGSize
//        if(widthRatio > heightRatio) {
//            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
//        } else {
//            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//        }
//
//        // This is the rect that we've calculated out and this is what is actually used below
//        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//
//        // Actually do the resizing to the rect using the ImageContext stuff
//        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//        image.draw(in: rect)
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return newImage!
//    }
    // MARK
//    что то сделать с фото, подержка нескольких фото вычисление размеров
    // добавить вычисление высоты ячейки в зависимости от размеров фото

}
extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
}
