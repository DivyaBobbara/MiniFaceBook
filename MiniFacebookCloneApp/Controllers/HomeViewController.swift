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
        callGetPosts()
    }
    func callGetPosts() {
        viewModelHome.getPostDetails { error in
            if error != nil {
                self.displayAlert(message: error?.localizedDescription ?? "")
                return
            }
            else{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    func callSuggestedFrnds() {
        viewModelHome.getSuggestedFrdsData { error in
            if error != nil {
                self.displayAlert(message: error?.localizedDescription ?? "")
                return
            }
            else{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }
    }
    
    @objc func updateLikesMethod(sender:UIButton)
    {
        var index = sender.tag
        print(index)
        let likeStatus = viewModelHome.getPostsResponse?.data[index].likeStatus
        viewModelHome.callUpdateLikes(getUserId: viewModelHome.getUserId ?? 0, getPostId: viewModelHome.getPostsResponse?.data[index].postId ?? 0, getStatus: !(likeStatus!)) {error   in
//
            self.callGetPosts()
                
            }
    }
    

    @objc func deletePost(sender: UIButton) {
        let index = sender.tag
        print(viewModelHome.getPostsResponse?.data[index].postId)
        let delPostId = viewModelHome.getPostsResponse?.data[index].postId
        viewModelHome.updateDeletePost(userId: viewModelHome.getUserId ?? 0, postId: delPostId ?? 0) { error in
            self.callGetPosts()
        }
    }
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        callGetPosts()
    }
    @objc func navigateToCreatePost(textField  :UITextField){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let cPostVc = storyboard.instantiateViewController(withIdentifier: "CreatePostViewController")
        self.navigationController?.pushViewController(cPostVc, animated: true)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        callSuggestedFrnds()
      callGetPosts()
        
    }
}
extension HomeViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModelHome.getPostsResponse?.data.count ?? 0 + 2
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
            customCell.configure(objectArray: self.viewModelHome.suggestedFrndsResponseData)
            customCell.didClickAddFriend = { [weak self] indexPath in
                let getFrdId = (self?.viewModelHome.suggestedFrndsResponseData[indexPath ?? 0].friendId ?? 0)
                self?.viewModelHome.postAddNewFriend(frdId : getFrdId, userId: self?.viewModelHome.getUserId ?? 0) { error in
                    self?.callSuggestedFrnds()
                    
                }
            }
            return customCell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellPosts",for:indexPath) as! PostsTableViewCell
            cell.profileImg.image = UIImage(named: "profile")
            cell.userName.text = viewModelHome.getPostsResponse?.data[indexPath.row-2].userName
            cell.timeLbl.text = "08:24"
            cell.postDataLbl.text = viewModelHome.getPostsResponse?.data[indexPath.row - 2].postData
            cell.postImg.image = UIImage(named: "postImg")
            cell.shareCountLbl.text = "12 shares"
            cell.commentsCountLbl.text = "35 comments"
            cell.sharesLbl.text = "Share"
            cell.shareIcon.image = UIImage(named:"share")
            cell.commentsLbl.text = "Comments"
            cell.commentIcon.image = UIImage(named: "comment")
            cell.likesCount.text = String(viewModelHome.getPostsResponse?.data[indexPath.row-2 ].totalLikes ?? 0)
            cell.delPost.addTarget(self, action: #selector(deletePost), for:.touchUpInside)
            cell.delPost.tag = indexPath.row - 2
            if let isCreated = viewModelHome.getPostsResponse?.data[indexPath.row-2].iscreated, (isCreated == "True") {
                cell.delPost.isHidden = false
            }
            else {
                cell.delPost.isHidden = true
            }
            if viewModelHome.getPostsResponse?.data[indexPath.row - 2].likeStatus == true{
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
    func statusAlert(errorMessage : String) {
        let statusAlert = UIAlertController(title: "Alert", message: "\(errorMessage)", preferredStyle: .alert)
        statusAlert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(statusAlert,animated: true)
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
    
    
     
    




