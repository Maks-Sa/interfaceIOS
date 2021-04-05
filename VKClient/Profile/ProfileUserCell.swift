//
//  ProfileUserCell.swift
//  VKClient
//
//  Created by Maksim Savin on 25.03.2021.
//

import UIKit

class ProfileUserCell: UITableViewCell {

    @IBOutlet weak var sexProfile: UILabel!
    @IBOutlet weak var bDayProfile: UILabel!
    @IBOutlet weak var aboutMyselfProfile: UILabel!
    @IBOutlet weak var lastNameProfile: UILabel!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var avatarProfile: IconSettings!
    
    
    func setData(sex: Int, bDay: String, aboytMyself: String, lastName: String, name: String, avatar: UIImage){
        switch sex {
        case 1:
            self.sexProfile.text = "Женский"
        case 2:
            self.sexProfile.text = "Мужской"
        default:
            self.sexProfile.text = "Не укзаан"
        }
        self.bDayProfile.text = bDay
        self.aboutMyselfProfile.text = aboytMyself
        self.lastNameProfile.text = lastName
        self.nameProfile.text = name
        self.avatarProfile.imageView.image = avatar
    }

    override func awakeFromNib() {
        super.awakeFromNib()
     
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
