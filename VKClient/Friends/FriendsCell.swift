//
//  FriendsCell.swift
//  VKClient
//
//  Created by Maksim Savin on 27.12.2020.
//

import UIKit

class FriendsCell: UITableViewCell {

    
    
    @IBOutlet weak var friendsCity: UILabel!
    @IBOutlet weak var friendsSername: UILabel!
    @IBOutlet weak var friendsName: UILabel!
    @IBOutlet weak var friendsAvatar: UIImageView!
    
    // Метод для заполнения ячейки данными
    func setData(city: String, name: String, sername: String, avatar: UIImage) {
        friendsCity.text = city
        friendsSername.text = sername
        friendsName.text = name
        friendsAvatar.image = avatar
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }

}
