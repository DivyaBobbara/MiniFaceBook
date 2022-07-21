//
//  HomeCreatePostTableViewCell.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 19/07/22.
//

import UIKit

class HomeCreatePostTableViewCell: UITableViewCell {

    @IBOutlet weak var textFieldPostData: UITextField!
    @IBOutlet weak var lblFacebook: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblFacebook.text = "Facebook"
//        textFieldPostData.addTarget(self, action: #selector(myTargetFunction), for: .touchDown)
        
    }
//    @objc func myTargetFunction(textField: UITextField) {
//        print("myTargetFunction")
//
//
//
//    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
