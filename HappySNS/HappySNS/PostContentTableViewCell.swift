//
//  PostContentTableViewCell.swift
//  HappySNS
//
//  Created by 徳永勇希 on 2020/11/25.
//

import UIKit

class PostContentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImagiView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var postTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
