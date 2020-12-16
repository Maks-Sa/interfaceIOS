//
//  AllGroupsViewCell.swift
//  VKClient
//
//  Created by Maksim Savin on 15.12.2020.
//

import UIKit

class AllGroupsViewCell: UITableViewCell {

    @IBOutlet weak var groupName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setData(name: String) {
        groupName.text = name
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
