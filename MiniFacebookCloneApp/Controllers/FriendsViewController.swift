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
        
//        viewModel.getDisplayFriendsData { result in
////            print(result.data[1].userName)
//            DispatchQueue.main.async {
//
//                self.tableView.reloadData()
//                print(self.viewModel.myResultObj.count)
//
//            }
//
//        }
//
    }
    @objc func callRemoveFrdApi(sender : UIButton){
        print("clicked")
        let index = sender.tag
        print(index)
        viewModel.deleteFrdDetails(friendId: viewModel.myResultObj[index].userId ?? 0, userId: viewModel.getUserId ?? 0) { res in
            print(res)
            self.viewModel.getDisplayFriendsData { DisplayFriendsResponse in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
        viewModel.getDisplayFriendsData { result in
//            print(result.data[1].userName)
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
                print(self.viewModel.myResultObj.count)

            }

        }
    }
//    @objc func navigateToHome(){
//        print("navigation clicked")
//        let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//        tabBarVC.selectedViewController = tabBarVC.viewControllers?[0]
//        present(tabBarVC, animated: true, completion: nil)
//
//    }
  


}
extension FriendsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.myResultObj.count+1
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let val = indexPath.row
        if val == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell0",for: indexPath) as! SearchFrdsTableViewCell
            
            cell.config(newArrObjSearch: viewModel.myResultObj)
//            cell.backToHomeBtn.addTarget(self, action: #selector(navigateToHome), for: .touchUpInside)
        return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsListCell",for: indexPath) as! FriendsTableViewCell
    //        cell.textLabel?.text = "dsfsdfsfs"
            cell.friendImg.image = UIImage(named: "profile")
            
            cell.friendName.text = viewModel.myResultObj[indexPath.row - 1].userName
            cell.friendId.text = String(viewModel.myResultObj[indexPath.row - 1].userId ?? 0)
            cell.removeBtn.addTarget(self, action: #selector(callRemoveFrdApi), for: .touchUpInside)
            cell.removeBtn.tag = indexPath.row - 1
            return cell
        }
    
    
    }
   
    
}

