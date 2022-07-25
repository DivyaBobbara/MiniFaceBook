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
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
                                    #selector(handleRefresh),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.red
        self.tableView.addSubview(refreshControl)
        tableView.allowsSelection = false
        tableView.rowHeight = UITableView.automaticDimension
        let createPostNib = UINib(nibName: "HomeCreatePostTableViewCell", bundle: nil)
        tableView.register(createPostNib, forCellReuseIdentifier: "Cell0")
        let suggestedNib = UINib(nibName: "SuggestedFrdsTableViewCell", bundle: nil)
        tableView.register(suggestedNib, forCellReuseIdentifier: "Cell1")
        viewModelHome.getPostDetails { postData in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func updateLikesMethod(sender:UIButton)
    {
        var index = sender.tag
        print(index)
        let likeStatus = viewModelHome.getPostsObj[index].likeStatus
        print("likeStatus\(likeStatus)")
        viewModelHome.callUpdateLikes(getUserId: viewModelHome.getUserId ?? 0, getPostId: viewModelHome.getPostsObj[index].postId ?? 0, getStatus: !(likeStatus!)) { UpdateLikes in
            self.viewModelHome.getPostDetails { GetPosts in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    @objc func deletePost(sender: UIButton) {
        let index = sender.tag
        print(viewModelHome.getPostsObj[index].postId)
        let delPostId = viewModelHome.getPostsObj[index].postId
        viewModelHome.updateDeletePost(userId: viewModelHome.getUserId ?? 0, postId: delPostId ?? 0) { delPost in
            self.viewModelHome.getPostDetails { GetPosts in
                DispatchQueue.main.async {
//                    self.viewModelHome.getPostsObj.remove(at: index)
//                    self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
                    self.tableView.reloadData()
                }
            }
        }
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        viewModelHome.getPostDetails { getPosts in
            self.tableView.reloadData()
            refreshControl.endRefreshing()
        }
    }
    @objc func navigateToCreatePost(textField  :UITextField){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cPostVc = storyboard.instantiateViewController(withIdentifier: "CreatePostViewController")
        self.navigationController?.pushViewController(cPostVc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        viewModelHome.getSuggestedFrdsData { result in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModelHome.getPostDetails{ postData in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                let getFrdId = (self?.viewModelHome.suggestedFrdsResponseObj[indexPath ?? 0].friendId ?? 0)
                self?.viewModelHome.postAddNewFriend(frdId:getFrdId, userId: self?.viewModelHome.getUserId ?? 0) { result in
                    let data = Data(result.utf8)
                    let response = try? JSONDecoder().decode(BadRequestAddNewFriend.self, from: data)
                    if response?.status == "client error"{
                        DispatchQueue.main.async {
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
            cell.timeLbl.text = "08:24"
            cell.postDataLbl.text = viewModelHome.getPostsObj[indexPath.row - 2].postData
            cell.postImg.image = UIImage(named: "postImg")
            cell.shareCountLbl.text = "12 shares"
            cell.commentsCountLbl.text = "35 comments"
            cell.sharesLbl.text = "Share"
            cell.shareIcon.image = UIImage(named:"share")
            cell.commentsLbl.text = "Comments"
            cell.commentIcon.image = UIImage(named: "comment")
            cell.likesCount.text = String(viewModelHome.getPostsObj[indexPath.row-2 ].totalLikes ?? 0)
            cell.delPost.addTarget(self, action: #selector(deletePost), for:.touchUpInside)
            cell.delPost.tag = indexPath.row - 2
            if let isCreated = viewModelHome.getPostsObj[indexPath.row-2].iscreated, (isCreated == "True") {
                cell.delPost.isHidden = false
            }
            else {
                cell.delPost.isHidden = true
            }
            if viewModelHome.getPostsObj[indexPath.row - 2].likeStatus == true{
                cell.likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
                cell.likeLbl.text = "Liked"
                
            }
            else{
                cell.likeButton.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
                cell.likeLbl.text = "Like"
                
            }
            cell.likeButton.addTarget(self, action: #selector(updateLikesMethod), for: .touchUpInside)
            cell.likeButton.tag = indexPath.row - 2
            
            
            return cell
        }
    }
    func showAlertMsg(errCode : Int)
    {
        let alert = UIAlertController(title: "Bad Request Error", message: " \(errCode) Error ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    
}
    
    
     
    




