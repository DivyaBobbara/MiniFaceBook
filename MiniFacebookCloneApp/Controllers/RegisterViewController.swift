//
//  RegisterViewController.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import UIKit


class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var backToLoginBtn: UIButton!
    @IBOutlet weak var userNameTxt:UITextField!
    @IBOutlet weak var emailTxt:UITextField!
    @IBOutlet weak var birthTxt:UITextField!
    @IBOutlet weak var passwordTxt:UITextField!
    @IBOutlet weak var cnfpasswordTxt:UITextField!
    @IBOutlet weak var genderTxt:UITextField!
    @IBOutlet weak var pswEyeButton:UIButton!
    @IBOutlet weak var cnfPsweyeButton:UIButton!
    
    
    @IBOutlet weak var tableview : UITableView!
    
    var datePicker : UIDatePicker!
    var flag : Int = 1
    
    
    var genderList: [String] = ["Male","Female"]
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginbutton : UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        loginbutton.layer.cornerRadius = 13
        registerBtn.layer.cornerRadius = 13
        backToLoginBtn.layer.cornerRadius = 13
        tableview.delegate = self
        tableview.dataSource = self
        tableview.isHidden = true
        view.addSubview(tableview)
        self.pickUpDate(self.birthTxt)
        
        pswEyeButton.addTarget(self, action: #selector(self.btnPasswordVisiblityClicked), for: .touchUpInside)
        passwordTxt.rightView = pswEyeButton
        passwordTxt.rightViewMode = .always
        
        cnfPsweyeButton.addTarget(self, action: #selector(self.btnCnfPasswordVisiblityClicked), for: .touchUpInside)
        cnfpasswordTxt.rightView = cnfPsweyeButton
        cnfpasswordTxt.rightViewMode = .always
    }
    @IBAction func btnPasswordVisiblityClicked(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.passwordTxt.isSecureTextEntry = false
            pswEyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            self.passwordTxt.isSecureTextEntry = true
            pswEyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    @IBAction func btnCnfPasswordVisiblityClicked(_ sender: Any) {
        (sender as! UIButton).isSelected = !(sender as! UIButton).isSelected
        if (sender as! UIButton).isSelected {
            self.cnfpasswordTxt.isSecureTextEntry = false
            cnfPsweyeButton.setImage(UIImage(systemName: "eye"), for: .normal)
        } else {
            self.cnfpasswordTxt.isSecureTextEntry = true
            cnfPsweyeButton.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        }
    }
    
    @IBAction func backToLoginBtnClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func dropDownBtnClicked(_ sender: Any){
        tableview.isHidden = false
        clickDropDown()
        view.addSubview(tableview)
    }
    func clickDropDown() {
        if flag == 0 {
            //            UIView.setAnimationDuration(0.5)
            self.tableview.isHidden = true
            self.flag = 1
        }
        else{
            //            UIView.setAnimationDuration(0.5)
            self.tableview.isHidden = false
            self.flag = 0
        }
    }
    
    
    
    @IBAction func registerButtonClicked(_ sender: Any)
    {
        if userNameTxt.text == ""
        {
            displayAlert(message: "Username is empty")
        }
        if emailTxt.text == ""
        {
            displayAlert(message: "Email is empty")
        }
        if invalidEmail(emailTxt.text ?? "") != true
        {
            displayAlert(message: "Invalid email format")
        }
        if birthTxt.text == ""
        {
            displayAlert(message: "Date of birth is empty")
        }
        if genderTxt.text == ""
        {
            displayAlert(message: "Gender is empty")
        }
        if passwordTxt.text == ""
        {
            displayAlert(message: "Password is empty")
        }
        if passwordTxt.text?.count ?? 0 < 8
        {
            displayAlert(message: "Password length must be 8 or above")
        }
        if isValidPassword(testStr: passwordTxt.text) != true {
            displayAlert(message: "Password must contain 1 upperCase,1 digit,1 lowercase")
        }
        if cnfpasswordTxt.text == ""
        {
            displayAlert(message: "Confirmpassword is empty")
        }
        if passwordTxt.text != cnfpasswordTxt.text
        {
            displayAlert(message: "Password must be same")
        }
        else{
            ViewModel.shared.callRegister(userName: userNameTxt.text ?? "", password: passwordTxt.text ?? "", dateOfbirth: birthTxt.text ?? "", email: emailTxt.text ?? "", gender: genderTxt.text ?? ""){ error in
                if error != nil {
                    self.displayAlert(message: error?.localizedDescription ?? "")
                    return
                }
                else {
                    
                    if ViewModel.shared.registerResponse?.status != "success" {
                        self.displayAlert(message: ViewModel.shared.registerResponse?.message ?? "")
                        
                    }
                    else {
                        DispatchQueue.main.async {
                            
                            self.navigationController?.popToRootViewController(animated: true)
                            self.userNameTxt.text = ""
                            self.genderTxt.text = ""
                            self.cnfpasswordTxt.text = ""
                            self.passwordTxt.text = ""
                            self.birthTxt.text = ""
                            self.emailTxt.text = ""
                        }
                        self.displayAlert(message: "Successfully Registered")
                    }
                }
                
                
            }
        }
        
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pickUpDate(self.birthTxt)
        
    }
    func pickUpDate(_ textField : UITextField){
        
        let myDate = Date()
        datePicker = UIDatePicker(frame:CGRect(x: 100, y: 200, width: view.frame.size.width, height: 216))
        datePicker.backgroundColor = UIColor.white
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.maximumDate = myDate
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
extension RegisterViewController : UITableViewDataSource,UITableViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genderList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = genderList[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 33.0
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.genderTxt.text = genderList[indexPath.row]
        self.tableview.isHidden = true
        
    }
}
