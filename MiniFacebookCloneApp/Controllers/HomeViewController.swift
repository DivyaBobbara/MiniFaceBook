//
//  ViewController.swift
//  MiniFaceBook
//
//  Created by Naga Divya Bobbara on 18/07/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let viewModelHome = ViewModel()
    var postIdValue : Int?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModelHome.getUserIdInfo()
        viewModelHome.callUpdateLikes()
        
        tableView.allowsSelection = false
//        tableView.estimatedRowHeight = 1000
        tableView.rowHeight = UITableView.automaticDimension
        let createPostNib = UINib(nibName: "HomeCreatePostTableViewCell", bundle: nil)
        tableView.register(createPostNib, forCellReuseIdentifier: "Cell0")
        let suggestedNib = UINib(nibName: "SuggestedFrdsTableViewCell", bundle: nil)
        tableView.register(suggestedNib, forCellReuseIdentifier: "Cell1")
        viewModelHome.getPostDetails { postData in
//            print(postData,"jhanujhanujhanu")
//            let result = Data(postData.utf8)
//            print(result,"indataForm")
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
//                print("homevcpost\(postData)")
//                print(self.viewModelHome.getPostsObj.count)
            }
            
        }
//        viewModelHome.postAddNewFriend { final_res in
//            print("final\(final_res)")
//        }
//        viewModelHome.deleteFrdDetails(friendId: 17, userId: 1) { res in
//            print("sdfghjk\(res)")
//        }
    }
    @objc func navigateToCreatePost(textField  :UITextField){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cPostVc = storyboard.instantiateViewController(withIdentifier: "CreatePostViewController")
        self.navigationController?.pushViewController(cPostVc, animated: true)
//        let tabBarVC = self.storyboard?.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
//        tabBarVC.selectedViewController = tabBarVC.viewControllers?[4]

        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModelHome.getSuggestedFrdsData { result in
            DispatchQueue.main.async {
                self.tableView.reloadData()
//                print("home vc\(self.viewModelHome.suggestedFrdsResponseObj)")
               
            }
        }
    }
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print("rows count\(viewModelHome.getPostsObj.count+2)")
        return viewModelHome.getPostsObj.count+2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let val = indexPath.row
        if val == 0{
            let customCell = tableView.dequeueReusableCell(withIdentifier: "Cell0",for: indexPath) as! HomeCreatePostTableViewCell
            customCell.textFieldPostData.addTarget(self, action: #selector(navigateToCreatePost), for: .touchDown)
            return customCell
        }
        if val == 1{
            let customCell = tableView.dequeueReusableCell(withIdentifier: "Cell1",for: indexPath) as! SuggestedFrdsTableViewCell
            customCell.configure(objectArray: self.viewModelHome.suggestedFrdsResponseObj)
            customCell.didClickAddFriend = { [weak self] indexPath in
//                print("Hi")
//                print(indexPath)
                let getFrdId = (self?.viewModelHome.suggestedFrdsResponseObj[indexPath ?? 0].friendId ?? 0)
                self?.viewModelHome.postAddNewFriend(frdId:getFrdId, userId: self?.viewModelHome.getUserId ?? 0) { result in
//                    print("res\(result)")
                    let data = Data(result.utf8)
                    let response = try? JSONDecoder().decode(BadRequestAddNewFriend.self, from: data)
                    if response?.status == "client error"{
                    DispatchQueue.main.async {
//                        print(response?.errorCode)
                        self?.showAlertMsg(errCode : response?.errorCode ?? 0)
                    }
                    }
                    self?.viewModelHome.getSuggestedFrdsData { res in
                        DispatchQueue.main.async {
                            self?.tableView.reloadData()
                        }
                    }
            }
            }
            return customCell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellPosts",for:indexPath) as! PostsTableViewCell
            cell.profileImg.image = UIImage(named: "profile")
            cell.userName.text = viewModelHome.getPostsObj[indexPath.row-2].userName
//            print(viewModelHome.getPostsObj[indexPath.row-2].userName,"posting username")
            cell.timeLbl.text = "08:24"
            cell.postDataLbl.text = viewModelHome.getPostsObj[indexPath.row-2].postData
            cell.postImg.image = UIImage(named: "postImg")
            cell.shareCountLbl.text = "12 shares"
            cell.commentsCountLbl.text = "35 comments"
            cell.sharesLbl.text = "Share"
            cell.shareIcon.image = UIImage(named:"share")
            cell.commentsLbl.text = "Comments"
            cell.commentIcon.image = UIImage(named: "comment")
            cell.likeLbl.text = "Like"
            cell.likesCount.text = String(viewModelHome.getPostsObj[indexPath.row-2 ].totalLikes ?? 0)
//            print(viewModelHome.getPostsObj)
            if viewModelHome.getPostsObj[indexPath.row - 2].isCreated  ==  true  && viewModelHome.getPostsObj[indexPath.row - 2].userId == viewModelHome.getUserId{
                cell.delIcon.image = UIImage(named: "trash")
            }
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            cell.likeIcon.isUserInteractionEnabled = true
            cell.likeIcon.addGestureRecognizer(tapGestureRecognizer)
            
            return cell
        }
    }
    func showAlertMsg(errCode : Int)
    {
        let alert = UIAlertController(title: "Bad Request Error", message: " \(errCode) Error ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView

        // Your action
//        imageView.image = UIImage(named:"homeSelected")
        let alert = UIAlertController(title: "success", message: "poikuyhtgr", preferredStyle: .alert)
        present(alert,animated: true)
    }
}


