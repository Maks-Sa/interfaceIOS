//
//  NewsPostCell.swift
//  VKClient
//
//  Created by Maksim Savin on 27.03.2021.
//

import UIKit

class NewsPostCell: UITableViewCell {

    
    @IBOutlet weak var timeNews: UILabel!
    
    @IBOutlet weak var textNews: UITextField!
    @IBOutlet weak var titleNews: UILabel!
    @IBOutlet weak var iconNews: IconSettings!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCount: NSLayoutConstraint!
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

}
