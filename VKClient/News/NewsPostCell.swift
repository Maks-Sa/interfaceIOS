//
//  NewsPostCell.swift
//  VKClient
//
//  Created by Maksim Savin on 27.03.2021.
//

import UIKit

class NewsPostCell: UITableViewCell {

    
    @IBOutlet weak var timeNews: UILabel!
    
    @IBOutlet weak var sourceNews: UILabel!
    @IBOutlet weak var textNews: UITextField!
    @IBOutlet weak var textPost: UILabel!
    @IBOutlet weak var iconNews: IconSettings!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: UILabel!
    @IBOutlet weak var commButton: UIButton!
    @IBOutlet weak var commCount: UILabel!
    @IBOutlet weak var repostButton: UIButton!
    @IBOutlet weak var repostCount: UILabel!
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
    func dateToString(date: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = "HH:mm dd/MM/yyyy"
        return dateFormatter.string(from: NSDate(timeIntervalSince1970: TimeInterval(date)) as Date)
    }
    
    func setData(timeNews: Int, textNews: String, textPost: String, sourceNews: String, iconNews: UIImage,  likeCount: Int, commCount: Int, repostCount: Int, viewCount: Int){
        self.timeNews.text = dateToString(date: timeNews)
        self.textNews.text = textNews
        self.textPost.text = textPost
        self.sourceNews.text = sourceNews
        self.iconNews.imageView.image = iconNews
        self.likeCount.text = "\(likeCount)"
        self.commCount.text = "\(commCount)"
        self.repostCount.text = "\(repostCount)"
        self.viewCount.text = "\(viewCount)"
    }
}
