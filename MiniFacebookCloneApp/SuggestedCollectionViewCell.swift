
//
//  SuggestedCollectionViewCell.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 19/07/22.
//

import UIKit

class SuggestedCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var removeFrdBtn: UIButton!
    @IBOutlet weak var addFrdBtn: UIButton!
    @IBOutlet weak var suggestedView: UIView!
    @IBOutlet weak var suggestedFrdId: UILabel!
    @IBOutlet weak var sugggestedFrdName: UILabel!
    @IBOutlet weak var imgFb: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        suggestedView.layer.cornerRadius = 15
        addFrdBtn.layer.cornerRadius = 6
        removeFrdBtn.layer.cornerRadius = 6
        
    }

    
}
