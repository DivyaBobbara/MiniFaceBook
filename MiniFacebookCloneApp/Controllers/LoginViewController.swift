//
//  ViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 20/07/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    let classModel = ViewModel()
    var valueOfUserId : Int?
    var loginStatusValue : Bool?
    @IBOutlet weak var imageview :UIImageView!
    @IBOutlet weak var loginButton :UIButton!
    @IBOutlet weak var registerButton :UIButton!
    @IBOutlet weak var forgetButton :UIButton!
    @IBOutlet weak var mailTxt :UITextField!
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
    
    @IBAction func goToRegisterBtn(_ sender : Any)
    {
        guard let  secondVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")else{
            return
        }
        navigationController?.pushViewController(secondVc, animated: true)
    }
    
    @IBAction func userLoginBtn(_ sender : Any)
    {
        if mailTxt.text == ""
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
            classModel.loginPassing(mail: mailTxt.text ?? "", userPassword: passwordTxt.text ?? "") { result in
                let data = Data(result.utf8)
                
                let model = try? JSONDecoder().decode(LoginResponse.self, from: data)
                let errorModel = try? JSONDecoder().decode(LoginError.self, from: data)
                DispatchQueue.main.async {
                    if errorModel?.errorCode != nil {
                        self.displayAlert(message: errorModel?.message ?? "")
                    }
                    else {
                        self.valueOfUserId = model?.data.userId
                        self.loginStatusValue = model?.data.loginStatus
                        
                        UserDefaults.standard.set(self.valueOfUserId, forKey: "keyId")
                        UserDefaults.standard.set(self.loginStatusValue, forKey: "loginstatus")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
                        self.navigationController?.pushViewController(tabBarVC, animated: true)
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


