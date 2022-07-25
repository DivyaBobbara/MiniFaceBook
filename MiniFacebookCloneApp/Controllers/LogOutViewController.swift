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
        //        self.navigationController?.isNavigationBarHidden = true
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate
        else {
            return
        }
        func resetWindow(with vc: UIViewController?) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                fatalError("could not get scene delegate ")
            }
            sceneDelegate.window?.rootViewController = vc
        }
        func showViewController(with id: String) {
            let vc = storyboard?.instantiateViewController(identifier: id)
            resetWindow(with: vc)
        }
        let alert = UIAlertController(title: "Logout?", message: "Are You Sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "logout", style: .default, handler: { [weak self] (_) in
            UserDefaults.standard.set(false, forKey: "loginstatus")
            showViewController(with: "LoginViewController")
            self?.viewModelLogOut.callLogOutApi { LogOutResponse in
                var logoutstatus = LogOutResponse.data.loginStatus
                print(logoutstatus)
            }
        }))
        present(alert,animated: true)
    }
}
  

   


