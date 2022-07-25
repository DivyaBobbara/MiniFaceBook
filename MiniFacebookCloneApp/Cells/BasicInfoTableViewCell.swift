//
//  BasicInfoTableViewCell.swift
//  FaceBookCloneApp
//
//  Created by Ramya Oduri on 18/07/22.
//

import UIKit

class BasicInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var basicLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
