
//
//  FriendsTableViewCell.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 18/07/22.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var friendId: UILabel!
    @IBOutlet weak var friendName: UILabel!
    @IBOutlet weak var friendImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        removeBtn.layer.cornerRadius = 6
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
