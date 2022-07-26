//
//  LogOutViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 21/07/22.
//

import UIKit

class LogOutViewController: UIViewController {
    let viewModelLogOut = ViewModel()
    var window : UIWindow?
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelLogOut.getUserIdInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
        //              let sceneDelegate = windowScene.delegate as? SceneDelegate
        //        else {
        //            return
        //        }
        func resetWindow(with vc: UIViewController?) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                fatalError("could not get scene delegate ")
            }
            sceneDelegate.window?.rootViewController = vc
        }
        func showViewController(with id: String) {
            let vc = storyboard?.instantiateViewController(identifier: id) as! LoginViewController
            let navVc = UINavigationController(rootViewController: vc)
            resetWindow(with: navVc)
            
        }
        let alert = UIAlertController(title: "Logout?", message: "Are You Sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "logout", style: .default, handler: { [weak self] (_) in
            
            
            self?.viewModelLogOut.callLogOutApi { LogOutResponse in
                let logoutstatus = LogOutResponse.data.loginStatus
                UserDefaults.standard.set(logoutstatus, forKey: "loginstatus")
                
                
            }
            showViewController(with: "LoginViewController")
        }))
        present(alert,animated: true)
    }
}





