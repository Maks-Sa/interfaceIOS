//
//  AllGroupsCell.swift
//  VKClient
//
//  Created by Maksim Savin on 24.12.2020.
//

import UIKit

class AllGroupsCell: UITableViewCell {

    
    @IBOutlet weak var allGroupsInfo: UILabel!
    @IBOutlet weak var allGroupsName: UILabel!
    @IBOutlet weak var allGroupsIcon: IconSettings!
    
    // Метод для заполнения ячейки данными
    func setData(groupName: String, groupInfo: String, groupIcon: UIImage){
        allGroupsName.text = groupName
        allGroupsInfo.text = groupInfo
        allGroupsIcon.imageView.image = groupIcon
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    
    }

}
