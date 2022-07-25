//
//  ContactTableViewCell.swift
//  FaceBookCloneApp
//
//  Created by Ramya Oduri on 18/07/22.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var contactLabel: UILabel!
    @IBOutlet weak var contactImg: UIImageView!
    @IBOutlet weak var phnNumlabel: UILabel!
    @IBOutlet weak var mailImg: UIImageView!
    @IBOutlet weak var mailIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
