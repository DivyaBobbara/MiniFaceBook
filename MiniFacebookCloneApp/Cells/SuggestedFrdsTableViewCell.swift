
//
//  SuggestedFrdsTableViewCell.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 19/07/22.
//

import UIKit

class SuggestedFrdsTableViewCell: UITableViewCell {
    var newObj = [SuggestedFriendsData]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleSuggested: UILabel!
    var didClickAddFriend: ((Int?) -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleSuggested.text = "People you may know"
        let suggestedCVNib = UINib(nibName: "SuggestedCollectionViewCell", bundle: nil)
        collectionView.register(suggestedCVNib, forCellWithReuseIdentifier: "cvSuggested")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(objectArray : [SuggestedFriendsData])
    {
        self.newObj = objectArray
        self.collectionView.reloadData()
    }
    @objc func callAddFrdApi(sender: UIButton)
    {
        didClickAddFriend?(sender.tag)

    }
   
    @objc func removeSuggestion(sender : UIButton){
        print("Remove friend suggestion button clicked")
//        let indexPath1 = IndexPath(row: sender.tag, section: 0)
//        self.collectionView.deleteItems(at: [indexPath1])
    }
}
extension SuggestedFrdsTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newObj.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cvCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvSuggested", for: indexPath) as! SuggestedCollectionViewCell
        cvCell.imgFb.image = UIImage(named: "fb")
        cvCell.sugggestedFrdName.text = newObj[indexPath.row].friendName
        cvCell.suggestedFrdId.text = (String(newObj[indexPath.row].friendId ?? 0) )
        cvCell.addFrdBtn.tag = indexPath.row
        cvCell.addFrdBtn.addTarget(self, action: #selector(callAddFrdApi), for: .touchUpInside)
        cvCell.removeFrdBtn.addTarget(self, action: #selector(removeSuggestion), for: .touchUpInside)
        cvCell.removeFrdBtn.tag = indexPath.row
        return cvCell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 295, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
        print(newObj[indexPath.row].friendId)
        
    }
    
}
