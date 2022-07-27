//
//  ViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 20/07/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let loginViewModelObj = ViewModel()
    var valueOfId : Int?
    var login : Bool?
    @IBOutlet weak var imageview :UIImageView!
    @IBOutlet weak var loginButton :UIButton!
    @IBOutlet weak var registerButton :UIButton!
    @IBOutlet weak var forgetButton :UIButton!
    @IBOutlet weak var nameTxt :UITextField!
    @IBOutlet weak var passwordTxt :UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = 8
        registerButton.layer.cornerRadius = 8
        imageview.layer.cornerRadius = 10
        
    }
    
    @IBAction func forgetPsw(_ sender: Any) {
        self.displayAlert(message: "We don't have forget pswd Api")
    }
    
    @IBAction func tappedOnButton(_ sender : Any)
    {
        guard let  secondVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")else
        {
            return
        }
        navigationController?.pushViewController(secondVc, animated: true)
    }
    
    @IBAction func tappedButton(_ sender : Any)
    {
        if nameTxt.text == ""
        {
            
            displayAlert(message: "mailid is empty")
            
        }
        if passwordTxt.text == ""
        {
            displayAlert(message: "password is empty")
            
        }
        if passwordTxt.text?.count ?? 0 < 8
        {
            displayAlert(message: "password must be greater than 8")
            
        }
        else{
            loginViewModelObj.callLogin(mail: nameTxt.text ?? "", userPassword: passwordTxt.text ?? "") { error in
                if error != nil {
                    self.displayAlert(message: error?.localizedDescription ?? "")
                    return
                }
                else{
                    
                        
                    if self.loginViewModelObj.loginresponse?.status != "success" {
//                        print("vduvduwqeho")
                        self.displayAlert(message: self.loginViewModelObj.loginresponse?.message ?? "")
                        }
                        else {
                            UserDefaults.standard.set(self.loginViewModelObj.loginresponse?.data?.userId, forKey: "keyId")
                            UserDefaults.standard.set(self.loginViewModelObj.loginresponse?.data?.loginStatus, forKey: "loginstatus")
                            DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
                            self.navigationController?.pushViewController(tabBarVC, animated: true)
                        }
                        }
//                        self.nameTxt.text = ""
//                        self.passwordTxt.text = ""
                    
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
                messageVC.dismiss(animated: true, completion: nil)})
        }
        }
    }
}


