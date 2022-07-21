//
//  ViewModel.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
import Foundation
class ViewModel
{
   let network = Networker()
    func passingData(userName : String ,password : String,dateOfbirth : String,email : String,gender : String, completion : @escaping(String)-> ())
       {
        network.postData(model: Details(userName: userName, dateOfBirth: dateOfbirth, gender: gender, mail: email, userPassword: password)) { result in
            completion(result)
        }
    }
    func  loginPassing(mail : String, userPassword : String ,completion : @escaping(String)-> ()){
        network.postingLoginData(model: LoginDetails(mail: mail, userPassword: userPassword)){ result in
//            print(result,"viewModel")
            completion(result)
        }
    }
}
