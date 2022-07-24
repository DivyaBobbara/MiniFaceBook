//
//  PostsTableViewCell.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 19/07/22.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var delPost: UIButton!
    @IBOutlet weak var likesCount: UILabel!
    @IBOutlet weak var commentIcon: UIImageView!
    
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLbl: UILabel!
    @IBOutlet weak var commentsLbl: UILabel!
    @IBOutlet weak var shareCountLbl: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var sharesLbl: UILabel!
    @IBOutlet weak var shareIcon: UIImageView!
    @IBOutlet weak var commentsCountLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    @IBOutlet weak var postDataLbl: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    

}
