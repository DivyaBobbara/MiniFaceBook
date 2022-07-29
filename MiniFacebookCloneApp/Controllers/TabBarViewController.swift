//
// TabBarViewController.swift
// MiniFacebookCloneApp
//
// Created by Naga Divya Bobbara on 21/07/22.
//

import UIKit

class TabBarViewController: UITabBarController,UITabBarControllerDelegate{
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.delegate = self
        ViewModel.shared.callLogOut{ error in
            if error != nil {
                self.displayAlert(message: error?.localizedDescription ?? "")
                return
            }
            else {
                var logoutstatus = ViewModel.shared.logoutResponse?.data.loginStatus
                UserDefaults.standard.set(logoutstatus, forKey: "loginstatus")
                DispatchQueue.main.async {
                    self.showViewController(with: "LoginViewController")
                }
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
    func showViewController(with id: String) {
        let vc = storyboard?.instantiateViewController(identifier: id) as! LoginViewController
        let navVc = UINavigationController(rootViewController: vc)
        navVc.isNavigationBarHidden = true
        resetWindow(with: navVc)
    }
    func resetWindow(with vc: UIViewController?) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
            fatalError("could not get scene delegate ")
        }
        sceneDelegate.window?.rootViewController = vc
    }
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if tabBarController.selectedIndex == 4{
            let alert = UIAlertController(title: "Logout?", message: "Are You Sure?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Logout", style: .default, handler: { [weak self] (_) in
                ViewModel.shared.callLogOut{ error in
                    if error != nil {
                        self?.displayAlert(message: error?.localizedDescription ?? "")
                        return
                    }
                    else {
                        var logoutstatus = ViewModel.shared.logoutResponse?.data.loginStatus
                        UserDefaults.standard.set(logoutstatus, forKey: "loginstatus")
                        DispatchQueue.main.async {
                            self?.showViewController(with: "LoginViewController")
                        }
                    }
                }
                
            }))
            present(alert,animated: true)
        }
    }
    
}
