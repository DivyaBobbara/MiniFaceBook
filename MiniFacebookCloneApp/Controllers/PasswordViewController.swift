//
//  ChangePswViewController.swift
//  FaceBookCloneApp
//
//  Created by Ramya Oduri on 19/07/22.
//

import UIKit

class PasswordViewController: UIViewController {
  
    let network = Networker()
    
    
    
    @IBOutlet var changePswLabel : UILabel!
    
    @IBOutlet weak var confirmPsw: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var pswEyeButton:UIButton!
    @IBOutlet weak var cnfPsweyeButton:UIButton!
    @IBOutlet weak var leftArrowBtn : UIButton!
    @IBOutlet weak var submitBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        self.tabBarController?.tabBar.isHidden = true
        submitBtn.layer.cornerRadius = 10
        ViewModel.shared.getUserIdInfo()
        pswEyeButton.addTarget(self, action: #selector(self.btnPasswordVisiblityClicked), for: .touchUpInside)
        password.rightView = pswEyeButton
        password.rightViewMode = .always
        
        cnfPsweyeButton.addTarget(self, action: #selector(self.btnCnfPasswordVisiblityClicked), for: .touchUpInside)
        confirmPsw.rightView = cnfPsweyeButton
        confirmPsw.rightViewMode = .always
    }
    
    @IBAction func btnPasswordVisiblityClicked(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.password.isSecureTextEntry = false
            pswEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            self.password.isSecureTextEntry = true
            pswEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    @IBAction func btnCnfPasswordVisiblityClicked(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.confirmPsw.isSecureTextEntry = false
            cnfPsweyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            self.confirmPsw.isSecureTextEntry = true
            cnfPsweyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    //    @IBAction func backToLogin(_ sender: Any) {
    //        self.navigationController?.popToRootViewController(animated: true)
    //    }
    
    @IBAction func changePasswordBtnClicked(_ sender: Any) {
        
        if (password.text == "" || confirmPsw.text == ""){
            displayAlert(message: "enter details")
        }
        else if password.text?.count ?? 0 < 8 {
            displayAlert(message: "Password must be greater than 8 characters")
        }
        
        else if(password.text != confirmPsw.text){
            displayAlert(message: "Password doesn't match")
        }
        else if isValidPassword(testStr: password.text) != true {
            displayAlert(message: "Password must contain 1 upperCase,1 digit,1 lowercase")
        }
        else{
            ViewModel.shared.callChangePassword(newPassword: password.text ?? "", confirmPassword: confirmPsw.text ?? "") { error in
                if error != nil {
                    self.displayAlert(message: error?.localizedDescription ?? "")
                    return
                }
                else {
                    self.displayAlert(message: ViewModel.shared.changePasswordresponse?.message ?? "")
                    DispatchQueue.main.async {
                        self.confirmPsw.text = ""
                        self.password.text = ""
                    }
                }
                
                
            }
            
        }
    }
    @IBAction func backBtnClicked(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
        
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
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        if !passwordTest.evaluate(with: testStr){
            return false
        }
        return true
    }
}
