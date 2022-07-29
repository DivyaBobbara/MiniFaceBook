//
//  PasswordTableViewCell.swift
//  FaceBookCloneApp
//
//  Created by Ramya Oduri on 18/07/22.
//

import UIKit

class ChangePasswordTableViewCell: UITableViewCell {
    @IBOutlet weak var pswLabel: UIButton!
    @IBOutlet weak var editLabel: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pswbutton: UIButton!
    
//    @IBAction func editBtn(_ sender: Any) {
//    }
    @IBAction func pswBtn(_ sender: Any) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
//        editLabel.layer.cornerRadius = 6
        pswbutton.layer.cornerRadius = 6 

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
