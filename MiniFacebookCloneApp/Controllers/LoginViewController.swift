//
//  ViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 20/07/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let loginViewModel = ViewModel()
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
        guard let pswStoryboard = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") else{
            return
        }
        navigationController?.pushViewController(pswStoryboard, animated: true)
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
            loginViewModel.loginPassing(mail: nameTxt.text ?? "", userPassword: passwordTxt.text ?? "") { error in
                if error != nil {
                    self.displayAlert(message: error?.localizedDescription ?? "")
                    return
                }
                else{
                    DispatchQueue.main.async { [self] in
                                          UserDefaults.standard.set(loginViewModel.loginresponse?.data.userId, forKey: "keyId")
                        UserDefaults.standard.set(loginViewModel.loginresponse?.data.loginStatus, forKey: "loginstatus")
                        if loginViewModel.loginresponse?.errorCode != nil{
                            self.displayAlert(message: loginViewModel.loginresponse?.message ?? "")
                        }
                        else {
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
                            self.navigationController?.pushViewController(tabBarVC, animated: true)
                        }
                        self.nameTxt.text = ""
                        self.passwordTxt.text = ""
                    }
                }
                
            }
        }
    }
    func displayAlert(message : String)
    {
        let messageVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
        present(messageVC, animated: true) {
            Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { (_) in
                messageVC.dismiss(animated: true, completion: nil)})
            
        }
    }
}


