//
//  FriendsViewController.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 18/07/22.
//

import UIKit

class FriendsViewController: UIViewController {
    let viewModel = ViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchNib = UINib(nibName: "SearchFrdsTableViewCell", bundle: nil)
        tableView.register(searchNib, forCellReuseIdentifier: "cell0")
        tableView.allowsSelection = false
    }
    @objc func callRemoveFrdApi(sender : UIButton){
        let index = sender.tag
        viewModel.deleteFrdDetails(friendId: viewModel.displayFrndsResponseData[index].userId ?? 0, userId: viewModel.getUserId ?? 0) { error in
            if error != nil {
                self.displayAlert(message: error?.localizedDescription ?? "")
                return
            }
            else{
            self.viewModel.getDisplayFriendsData { error in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getDisplayFriendsData { error in
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
}

extension FriendsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (viewModel.displayFrndsResponseData.count ?? 0) + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let val = indexPath.row
        if val == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell0",for: indexPath) as! SearchFrdsTableViewCell
            cell.config(newArrObjSearch: viewModel.displayFrndsResponseData)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsListCell",for: indexPath) as! FriendsTableViewCell
            cell.friendImg.image = UIImage(named: "profile")
            cell.friendName.text = viewModel.displayFrndsResponseData[indexPath.row - 1].userName
            cell.friendId.text = String(viewModel.displayFrndsResponseData[indexPath.row - 1].userId ?? 0)
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

