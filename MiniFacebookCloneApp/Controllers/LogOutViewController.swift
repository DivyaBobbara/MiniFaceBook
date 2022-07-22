//
//  LogOutViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 21/07/22.
//

import UIKit

class LogOutViewController: UIViewController {
    
    let viewModelLogOut = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelLogOut.getUserIdInfo()
       
       

        
    }
    override func viewWillAppear(_ animated: Bool) {
        let alert = UIAlertController(title: "LogOut?", message: "Are You Sure?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "logOut", style: .default, handler: { [weak self] (_) in
            
            self?.navigationController?.popToRootViewController(animated: true)
            self?.viewModelLogOut.callLogOutApi { LogOutResponse in
                print(LogOutResponse.data.userId,LogOutResponse.message)
            }
            
        }))
        
        present(alert,animated: true)
    }

   

}
