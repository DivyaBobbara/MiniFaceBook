//
// CreatePostViewController.swift
// MiniFacebookCloneApp
//
// Created by Naga Divya Bobbara on 21/07/22.
//

import UIKit

class CreatePostViewController: UIViewController {
    let createViewModelObj = ViewModel()
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var createPost: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        createViewModelObj.getUserIdInfo()
        postBtn.layer.cornerRadius = 8
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    @IBAction func Submit() {
        print("you are clicked")
        createViewModelObj.PrintResponse(postData: createPost.text ?? "") {result in
            let data = Data(result.utf8)
            let model = try? JSONDecoder().decode(Welcome.self, from: data)
            DispatchQueue.main.async {
                self.createPost.text = ""
            }
        }
        let createAlert = UIAlertController(title: "Done", message: "Post created successfully", preferredStyle: .alert)
        createAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(createAlert, animated: true)
    }
}
















