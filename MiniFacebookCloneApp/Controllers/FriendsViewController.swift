//
//  FriendsViewController.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 18/07/22.
//

import UIKit

class FriendsViewController: UIViewController {
   
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchNib = UINib(nibName: "SearchFrdsTableViewCell", bundle: nil)
        tableView.register(searchNib, forCellReuseIdentifier: "cell0")
        tableView.allowsSelection = false
    }
    func callDisplayFriendsApi(){
        ViewModel.shared.getDisplayFriendsData { error in
            if error != nil {
                self.displayAlert(message: error?.localizedDescription ?? "")
                return
            }
            else {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    @objc func callRemoveFrdApi(sender : UIButton){
        let index = sender.tag
        ViewModel.shared.deleteFrdDetails(friendId: ViewModel.shared.displayFrndsResponseData[index].userId ?? 0, userId: ViewModel.shared.getUserId ?? 0) { [self] error in
            if error != nil {
                self.displayAlert(message: error?.localizedDescription ?? "")
                return
            }
            else{
                self.callDisplayFriendsApi()
            }
            self.displayAlert(message: "Removed Your Friend!")
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        callDisplayFriendsApi()
        
    }
}

extension FriendsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (ViewModel.shared.displayFrndsResponseData.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let val = indexPath.row
        if val == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0",for: indexPath) as! SearchFrdsTableViewCell
            cell.config(newArrObjSearch: ViewModel.shared.displayFrndsResponseData)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsListCell",for: indexPath) as! FriendsTableViewCell
            cell.friendImg.image = UIImage(named: "profile")
            cell.friendName.text = ViewModel.shared.displayFrndsResponseData[indexPath.row - 1].userName
            cell.friendId.text = String(ViewModel.shared.displayFrndsResponseData[indexPath.row - 1].userId ?? 0)
            cell.removeBtn.addTarget(self, action: #selector(callRemoveFrdApi), for: .touchUpInside)
            cell.removeBtn.tag = indexPath.row - 1
            return cell
        }
    }
    func displayAlert(message : String)
    {
        let messageVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        DispatchQueue.main.async {
            self.present(messageVC, animated: true) {
                Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { (_) in
                    messageVC.dismiss(animated: true, completion: nil)})}
        }
    }
}

