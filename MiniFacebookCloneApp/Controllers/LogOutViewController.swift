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
            let vc = storyboard?.instantiateViewController(identifier: id) as! LoginViewController
            let navVc = UINavigationController(rootViewController: vc)
            resetWindow(with: navVc)
        }
        let alert = UIAlertController(title: "Logout?", message: "Are You Sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "logout", style: .default, handler: { [weak self] (_) in
            
            
            self?.viewModelLogOut.callLogOutApi {error  in
                
            
                print(error)
                if error == nil {
                    var logoutstatus = self?.viewModelLogOut.logoutResponse?.data.loginStatus
                    UserDefaults.standard.set(logoutstatus, forKey: "loginstatus")
                }
                else {
                    self?.displayAlert(message: error?.localizedDescription ?? "")
                }
                
                
                
            }
            showViewController(with: "LoginViewController")
        }))
        present(alert,animated: true)
    }
    func statusAlert(errorMessage :Error?) {
        let statusAlert = UIAlertController(title: nil, message: "\(errorMessage)", preferredStyle: .alert)
        statusAlert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        present(statusAlert,animated: true)
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
  

   


