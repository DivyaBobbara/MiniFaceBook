//
//  ViewController.swift
//  FaceBookCloneApp
//
//  Created by Ramya Oduri on 18/07/22.
//

import UIKit

class ProfileViewController: UIViewController , UITableViewDelegate,UITableViewDataSource {
    
    var viewModelObj = ViewModel()
    
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.allowsSelection = false
        tableview.delegate = self
        tableview.dataSource = self
        viewModelObj.getUserIdInfo()
        viewModelObj.ProfileDetails { data in
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        
        let mainNib = UINib(nibName: "ProfileNameTableViewCell", bundle: nil)
            tableview.register(mainNib, forCellReuseIdentifier: "mainCell")
        
        let imageNib = UINib(nibName: "ProfileImageTableViewCell", bundle: nil)
            self.tableview.register(imageNib, forCellReuseIdentifier: "imageCell")
        
        let passwordNib = UINib(nibName: "ChangePasswordTableViewCell", bundle: nil)
            self.tableview.register(passwordNib, forCellReuseIdentifier: "pswCell")
        
        let contactNib = UINib(nibName: "ContactTableViewCell", bundle: nil)
            self.tableview.register(contactNib, forCellReuseIdentifier: "contactCell")
        
        let basicInfoNib = UINib(nibName: "BasicInfoTableViewCell", bundle: nil)
            self.tableview.register(basicInfoNib, forCellReuseIdentifier: "basicInfoCell")
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row
        {
        case 0 : return 50
        case 1 : return 150
        case 2 : return 120
        case 3 : return 130
        case 4 : return 120
        default:
            return 200
        }
    }
    
    func tableView(_ tableview: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0 :
            let cell = tableview.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath)
            return cell
        case 1 :
            let cell = tableview.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
            return cell
        case 2 :
            let cell = tableview.dequeueReusableCell(withIdentifier: "pswCell", for: indexPath) as! ChangePasswordTableViewCell
            cell.nameLabel.text = viewModelObj.model1?.userName
            cell.pswbutton.addTarget(self, action: #selector(pswChangeTapped(_:)), for: .touchUpInside)
            return cell
        case 3 :
            let cell = tableview.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as! ContactTableViewCell
            cell.mailIdLabel.text = viewModelObj.model1?.mail
            cell.phnNumlabel.text = "9873456927"
            
            return cell
        case 4 :
            let cell = tableview.dequeueReusableCell(withIdentifier: "basicInfoCell", for: indexPath) as! BasicInfoTableViewCell
            cell.dobLabel.text = viewModelObj.model1?.dateOfBirth
            cell.genderLabel.text = viewModelObj.model1?.gender
            return cell
        default :
            let cell = tableview.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath)
            return cell
        }
    }
    
    @objc func pswChangeTapped(_ sender: UIButton){
        guard let secondvc = self.storyboard?.instantiateViewController(withIdentifier: "PasswordViewController") else {
            return
        }
        navigationController?.pushViewController(secondvc, animated: true)
    }

    
}




