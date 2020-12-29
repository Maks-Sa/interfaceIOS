//
//  MyGroupsCell.swift
//  VKClient
//
//  Created by Maksim Savin on 25.12.2020.
//

import UIKit

class MyGroupsCell: UITableViewCell {

  
    @IBOutlet weak var myGroupsIcon: UIImageView!
    @IBOutlet weak var myGroupsInfo: UILabel!
    @IBOutlet weak var myGroupsName: UILabel!
    
    // Метод для заполнения ячейки данными
    func setData(groupName: String, groupInfo: String, groupIcon: UIImage){
        myGroupsName.text = groupName
        myGroupsInfo.text = groupInfo
        myGroupsIcon.image = groupIcon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
