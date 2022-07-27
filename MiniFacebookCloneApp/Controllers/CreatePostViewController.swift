//
// CreatePostViewController.swift
// MiniFacebookCloneApp
//
// Created by Naga Divya Bobbara on 21/07/22.
//

import UIKit

class CreatePostViewController: UIViewController {
    let createPostViewModelObj = ViewModel()
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var createPost: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createPostViewModelObj.getUserIdInfo()
        postBtn.layer.cornerRadius = 8
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func Submit() {
        createPostViewModelObj.callCreatePost(postData: createPost.text ?? "") {error in
            if error != nil {
                self.displayAlert(message: error?.localizedDescription ?? "")
                return
            }
            DispatchQueue.main.async {
                let createAlert = UIAlertController(title: nil, message: self.createPostViewModelObj.creataPostResponse?.message, preferredStyle: .alert)
                createAlert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(createAlert, animated: true)
                self.createPost.text = ""
            }
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
















