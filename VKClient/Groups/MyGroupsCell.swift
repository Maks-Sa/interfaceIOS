//
//  MyGroupsCell.swift
//  VKClient
//
//  Created by Maksim Savin on 25.12.2020.
//

import UIKit

class MyGroupsCell: UITableViewCell {

  

    @IBOutlet weak var myGroupsInfo: UILabel!
    @IBOutlet weak var myGroupsName: UILabel!
    @IBOutlet weak var myGroupsIcon: IconSettings!
    
    // Метод для заполнения ячейки данными
    func setData(groupName: String, groupInfo: String, groupIcon: UIImage){
        myGroupsName.text = groupName
        myGroupsInfo.text = groupInfo
        myGroupsIcon.imageView.image = groupIcon
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
