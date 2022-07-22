//
//  ChangePswViewController.swift
//  FaceBookCloneApp
//
//  Created by Ramya Oduri on 19/07/22.
//

import UIKit

class PasswordViewController: UIViewController {
    let passwordViewModel = ViewModel()
    let network = Networker()
    var successMsg : String?
    var errormsg : String?
    
    
    @IBOutlet var changePswLabel : UILabel!
    
    @IBOutlet weak var confirmPsw: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var userName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordViewModel.getUserIdInfo()
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func changePasswordBtn(_ sender: Any) {
        
        if (password.text == "" || confirmPsw.text == "" || userName.text == ""){
            displayAlert(message: "enter details")
        }
        else if password.text?.count ?? 0 < 8 {
            displayAlert(message: "must be greater than 8 characters")
        }
    
        else if(password.text != confirmPsw.text){
            displayAlert(message: "Password doesn't match")
        }
        else{
            self.navigationController?.popToRootViewController(animated: true)
            //self.navigationController?.popViewController(animated: true)
//            network.postPassword(userId: passwordViewModel.getUserId ?? 0, model:Model(newPassword: password.text ?? "", confirmPassword: confirmPsw.text ?? "") , completion: {result in
//                let data = Data(result.utf8)
//                let model = try? JSONDecoder().decode(Response.self,from:data)
//                DispatchQueue.main.async {
//                    self.successMsg = model?.message
//                    self.displayAlert(message: self.successMsg!)
//                }
//
//            })
        }
    }
    
    func displayAlert(message : String)
      {
       let messageVC = UIAlertController(title: "", message: message, preferredStyle: .alert)
       present(messageVC, animated: true) {
             Timer.scheduledTimer(withTimeInterval: 0.4, repeats: false, block: { (_) in
               messageVC.dismiss(animated: true, completion: nil)})}
      }
}
