//
//  CreatePostViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 21/07/22.
//

import UIKit

class CreatePostViewController: UIViewController {
  let createViewModelObj = ViewModel()
  @IBOutlet weak var createPost: UITextField!
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  @IBAction func Submit() {
    print("you are clicked")
    createViewModelObj.PrintResponse(postData: createPost.text ?? "") {result in
      let data = Data(result.utf8)
      let model = try? JSONDecoder().decode(Welcome.self, from: data)
      DispatchQueue.main.async {
//        self.messageResponse.text = model?.message
          self.navigationController?.popToViewController(HomeViewController(), animated: true)
      }
    }
  }
}
