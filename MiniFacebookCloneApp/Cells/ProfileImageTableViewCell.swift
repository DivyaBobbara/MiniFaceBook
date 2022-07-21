//
//  ImageTableViewCell.swift
//  FaceBookCloneApp
//
//  Created by Ramya Oduri on 18/07/22.
//

import UIKit

class ProfileImageTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
