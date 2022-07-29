//
// LogOutViewController.swift
// MiniFacebookCloneApp
//
// Created by Naga Divya Bobbara on 21/07/22.
//

import UIKit

class LogOutViewController: UIViewController ,UITabBarDelegate{
  
//  var window : UIWindow?
  override func viewDidLoad() {
    super.viewDidLoad()
      ViewModel.shared.getUserIdInfo()
//    logOutAlert()
  }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)


  }
}
