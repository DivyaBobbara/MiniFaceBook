//
//  RegisterViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import UIKit


class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    let registerViewModelObj = ViewModel()
    var msg :  String?
    var errorMsg : String?
    @IBOutlet weak var userNameTxt:UITextField!
    @IBOutlet weak var emailTxt:UITextField!
    @IBOutlet weak var birthTxt:UITextField!
    @IBOutlet weak var passwordTxt:UITextField!
    @IBOutlet weak var cnfpasswordTxt:UITextField!
    @IBOutlet weak var genderTxt:UITextField!
    //@IBOutlet weak var eyeButton:UIButton!
    
    @IBOutlet weak var tableview : UITableView!
    
    var datePicker : UIDatePicker!

      var list = ["Male","Female"]
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginbutton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginbutton.layer.cornerRadius = 8
        registerBtn.layer.cornerRadius = 8
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isHidden = true
        self.pickUpDate(self.birthTxt)
    }
    
    @IBAction func backToLogin(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func dropDownBtn(_ sender: Any){
        tableview.isHidden = false
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
        if isValidPassword(testStr: passwordTxt.text) != true {
              displayAlert(message: "Password must contain 1 upperCase,1 digit,1 lowercase")
            }
        else{
            registerViewModelObj.callRegister(userName: userNameTxt.text ?? "", password: passwordTxt.text ?? "", dateOfbirth: birthTxt.text ?? "", email: emailTxt.text ?? "", gender: genderTxt.text ?? ""){ error in
                if error != nil {
                    self.displayAlert(message: error?.localizedDescription ?? "")
                    return
                }
                else {
                   
                        if self.registerViewModelObj.registerResponse?.status != "success" {
                            self.displayAlert(message: self.registerViewModelObj.registerResponse?.message ?? "")
                        }
                        else {
                            DispatchQueue.main.async {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
                
                
            }
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickUpDate(self.birthTxt)
      }

      func pickUpDate(_ textField : UITextField){


        datePicker = UIDatePicker(frame:CGRect(x: 100, y: 200, width: view.frame.size.width, height: 216))
        datePicker.backgroundColor = UIColor.white
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        //self.view.addSubview(datePicker)
        textField.inputView = self.datePicker


        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()


        let doneButton = UIBarButtonItem(title: "Set", style: .plain, target: self, action: #selector(doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar

      }


      @objc func doneClick() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy/MM/dd"
        birthTxt.text = dateFormatter.string(from: datePicker.date)
        birthTxt.resignFirstResponder()
      }
      @objc func cancelClick() {
        birthTxt.resignFirstResponder()
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
    func isValidPassword(testStr:String?) -> Bool {
        guard testStr != nil else { return false }
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
        if !passwordTest.evaluate(with: testStr){
          return false
        }
        return true
      }
}
extension RegisterViewController : UITableViewDataSource,UITableViewDelegate{
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return list.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = list[indexPath.row]
    return cell
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 30.0
  }
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.genderTxt.text = list[indexPath.row]
    self.tableview.isHidden = true

  }
}
