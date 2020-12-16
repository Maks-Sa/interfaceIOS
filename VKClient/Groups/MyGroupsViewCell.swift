//
//  MyGroupsViewCell.swift
//  VKClient
//
//  Created by Maksim Savin on 15.12.2020.
//

import UIKit

class MyGroupsViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
