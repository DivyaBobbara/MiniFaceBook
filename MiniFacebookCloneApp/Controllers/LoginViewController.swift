//
//  ViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Naga Divya Bobbara on 20/07/22.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var imageview :UIImageView!
    @IBOutlet weak var loginButton :UIButton!
    @IBOutlet weak var registerButton :UIButton!
    @IBOutlet weak var forgetButton :UIButton!
    @IBOutlet weak var nameTxt :UITextField!
    @IBOutlet weak var passwordTxt :UITextField!
    @IBOutlet weak var eyeButton :UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 10
        registerButton.layer.cornerRadius = 10
        imageview.layer.cornerRadius = 10
        
        eyeButton.addTarget(self, action: #selector(self.btnPasswordVisiblityClicked), for: .touchUpInside)
        passwordTxt.rightView = eyeButton
        passwordTxt.rightViewMode = .always
    }
    @IBAction func btnPasswordVisiblityClicked(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.passwordTxt.isSecureTextEntry = false
            eyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            self.passwordTxt.isSecureTextEntry = true
            eyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    @IBAction func forgetPswBtnClicked(_ sender: Any) {
        self.displayAlert(message: "We don't have forget pswd Api")
    }
    
    @IBAction func goToRegisterBtnClicked(_ sender : Any)
    {
        guard let  secondVc = self.storyboard?.instantiateViewController(withIdentifier: "RegisterViewController")else
        {
            return
        }
        navigationController?.pushViewController(secondVc, animated: true)
    }
    
    
    
    @IBAction func userLoginButtonClicked(_ sender : Any)
    {
        if nameTxt.text == ""
        {
            displayAlert(message: "mailid is empty")
        }
        if invalidEmail(nameTxt.text ?? "") != true
        {
            displayAlert(message: "Invalid email format")
        }
        if passwordTxt.text == ""
        {
            displayAlert(message: "password is empty")
        }
        if passwordTxt.text?.count ?? 0 < 8
        {
            displayAlert(message: "password must be greater than 8")
        }
        if isValidPassword(testStr: passwordTxt.text) != true {
            displayAlert(message: "Password must contain 1 upperCase,1 digit,1 lowercase")
        }
        else{
            ViewModel.shared.callLogin(mail: nameTxt.text ?? "", userPassword: passwordTxt.text ?? "") { error in
                if error != nil {
                    self.displayAlert(message: error?.localizedDescription ?? "")
                    return
                }
                else{
                    if ViewModel.shared.loginresponse?.status != "success" {
                        
                        self.displayAlert(message: ViewModel.shared.loginresponse?.message ?? "")
                    }
                    else {
                        UserDefaults.standard.set(ViewModel.shared.loginresponse?.data?.userId, forKey: "keyId")
                        UserDefaults.standard.set(ViewModel.shared.loginresponse?.data?.loginStatus, forKey: "loginstatus")
                        DispatchQueue.main.async {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let tabBarVC = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
                            self.navigationController?.pushViewController(tabBarVC, animated: true)
                            self.nameTxt.text = ""
                            self.passwordTxt.text = ""
                        }
                    }
                    
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
    func invalidEmail(_ value :  String) -> Bool
    {
        let regularExpresion = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpresion)
        if !predicate.evaluate(with: value)
        {
            return false
        }
        return true
    }
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        if !passwordTest.evaluate(with: testStr){
            return false
        }
        return true
    }
}





