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
//        self.navigationController?.isNavigationBarHidden = true
    }
 @IBAction func Submit() {
    
  print("you are clicked")
  createViewModelObj.PrintResponse(postData: createPost.text ?? "") {result in
   let data = Data(result.utf8)

   let model = try? JSONDecoder().decode(Welcome.self, from: data)
   DispatchQueue.main.async {
     print(model?.message)
//     self.navigationController?.popViewController(animated: true)
       self.createPost.text = ""
   }
  }
 }
}
















