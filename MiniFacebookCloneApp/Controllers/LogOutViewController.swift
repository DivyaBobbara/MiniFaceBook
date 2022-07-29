//
//  LogOutViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 21/07/22.
//

import UIKit

class LogOutViewController: UIViewController {
    let logOutViewModelObj = ViewModel()
    var window : UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        logOutViewModelObj.getUserIdInfo()
    }
   
}
  

   


