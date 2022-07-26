//
//  RegisterViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import UIKit


class RegisterViewController: UIViewController {
    
    let classModel = ViewModel()
    var msg :  String?
    var errorMsg : String?
    @IBOutlet weak var userNameTxt:UITextField!
    @IBOutlet weak var emailTxt:UITextField!
    @IBOutlet weak var birthTxt:UITextField!
    @IBOutlet weak var passwordTxt:UITextField!
    @IBOutlet weak var cnfpasswordTxt:UITextField!
    @IBOutlet weak var genderTxt:UITextField!
    @IBOutlet weak var eyeButton:UIButton!
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginbutton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginbutton.layer.cornerRadius = 8
        registerBtn.layer.cornerRadius = 8
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func buttonTapped(_ sender: Any)
    {
        if userNameTxt.text == ""
        {
            displayAlert(message: "Name is empty")
        }
        if emailTxt.text == ""
        {
            displayAlert(message: "email is empty")
        }
        if birthTxt.text == ""
        {
            displayAlert(message: "birthdate is empty")
        }
        if passwordTxt.text == ""
        {
            displayAlert(message: "password is empty")
        }
        if cnfpasswordTxt.text == ""
        {
            displayAlert(message: "cnfpassword is empty")
        }
        if passwordTxt.text?.count ?? 0 < 8
        {
            displayAlert(message: "password length must be 8 or above")
        }
        if passwordTxt.text != cnfpasswordTxt.text
        {
            displayAlert(message: "password must be same")
        }
        if invalidEmail(emailTxt.text ?? "") != "OK"
        {
            displayAlert(message: " correct email  format")
        }
        else{
            classModel.passingData(userName: userNameTxt.text ?? "", password: passwordTxt.text ?? "", dateOfbirth: birthTxt.text ?? "", email: emailTxt.text ?? "", gender: genderTxt.text ?? ""){ error in
                if error != nil {
                    self.displayAlert(message: error?.localizedDescription ?? "")
                    return
                }
                else {
                    DispatchQueue.main.async {
                        if self.classModel.registerResponse?.errorCode != nil {
                            self.displayAlert(message: self.classModel.resgisterErrorResponse?.message ?? "")
                        }
                        else {
                            
                            self.navigationController?.popToRootViewController(animated: true)
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
                    messageVC.dismiss(animated: true, completion: nil)})}
        }
    }
    func invalidEmail(_ value :  String) -> String
    {
        let regularExpresion = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regularExpresion)
        if !predicate.evaluate(with: value)
        {
            return "invalid"
        }
        return "OK"
    }
}
