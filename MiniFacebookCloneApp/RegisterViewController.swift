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
    @IBOutlet weak var UserNameTxt:UITextField!
    @IBOutlet weak var EmailTxt:UITextField!
    @IBOutlet weak var BirthTxt:UITextField!
    @IBOutlet weak var PasswordTxt:UITextField!
    @IBOutlet weak var CnfpasswordTxt:UITextField!
    @IBOutlet weak var genderTxt:UITextField!
    
    @IBOutlet weak var Loginbutton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    

    @IBAction func buttonTapped(_ sender: Any)
    {
        if UserNameTxt.text == ""
        {
            displayAlert(message: "Name is empty")
        }
        if EmailTxt.text == ""
        {
            displayAlert(message: "Number is empty")
        }
        if BirthTxt.text == ""
        {
            displayAlert(message: "birth is empty")
        }
        if PasswordTxt.text == ""
        {
            displayAlert(message: "password is empty")
        }
        if CnfpasswordTxt.text == ""
        {
            displayAlert(message: "cnfpassword is empty")
        }
        if PasswordTxt.text?.count ?? 0 < 8
        {
            displayAlert(message: "password length must be 8 or above")
        }
        if PasswordTxt.text != CnfpasswordTxt.text
        {
            displayAlert(message: "password must be same")
        }
        if invalidEmail(EmailTxt.text ?? "") != "OK"
        {
            displayAlert(message: "mail in the correct format")
        }
        else{
            classModel.passingData(userName: UserNameTxt.text ?? "", password: PasswordTxt.text ?? "", dateOfbirth: BirthTxt.text ?? "", email: EmailTxt.text ?? "", gender: genderTxt.text ?? ""){ result in
                let data = Data(result.utf8)
                
                let model = try? JSONDecoder().decode(RegisterResponse.self, from: data)
                let anotherModel = try? JSONDecoder().decode(RegisterError.self, from: data)
                DispatchQueue.main.async {
                if anotherModel?.errorCode == 409{
                        self.displayAlert(message: anotherModel?.message ?? "")
                    }
                    self.displayAlert(message: model?.message ?? "")
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
            

        }
       
     }
    func displayAlert(message : String)
    {
      let messageVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
      present(messageVC, animated: true) {
                 Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { (_) in
                     messageVC.dismiss(animated: true, completion: nil)})}
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
