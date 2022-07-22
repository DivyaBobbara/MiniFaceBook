//
//  SearchFrdsTableViewCell.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 18/07/22.
//

import UIKit

class SearchFrdsTableViewCell: UITableViewCell {
    var vmObjSearch = [MyResult]()
    
    @IBOutlet weak var backToHomeBtn: UIButton!
    @IBOutlet weak var friendCount: UILabel!
    @IBOutlet weak var recentBtn: UIButton!
    @IBOutlet weak var allBtn: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        allBtn.layer.cornerRadius = 10
        recentBtn.layer.cornerRadius = 10
        
        
    }
    func config(newArrObjSearch:[MyResult]){
        self.vmObjSearch = newArrObjSearch
//        print(vmObjSearch.count)
        self.friendCount.text = "\(self.vmObjSearch.count) Friends"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
   
}
