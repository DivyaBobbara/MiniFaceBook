//
//  SearchFrdsTableViewCell.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 18/07/22.
//

import UIKit

class SearchFrdsTableViewCell: UITableViewCell {
    var vmObjSearch = [DisplayFriendsData]()
    
    @IBOutlet weak var backToHomeBtn: UIButton!
    @IBOutlet weak var friendCount: UILabel!
   
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
    }
    func config(newArrObjSearch:[DisplayFriendsData]){
        self.vmObjSearch = newArrObjSearch
        self.friendCount.text = "\(self.vmObjSearch.count) Friends"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   
}
