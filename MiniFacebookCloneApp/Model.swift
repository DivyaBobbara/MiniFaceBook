//
//  Model.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
struct Details : Codable {
    let userName, dateOfBirth, gender, mail: String?
    let userPassword: String?
}
struct LoginDetails: Codable {
    let mail, userPassword: String
}
struct LoginResponse : Codable {
    let status, message: String?
    let data: DataClass
    let errorCode: String?
}
struct DataClass: Codable {
    let userId : Int?
    let loginStatus: Bool?
}
struct LoginError : Codable {
    let status, message :  String?
    let data : DataModel
    let errorCode: Int?
}
struct DataModel : Codable
{
    
}
struct RegisterResponse: Codable {
    let status, message: String?
    let data: DataRegister
    let erroCode: String?
}
struct DataRegister: Codable {
    let userName, gender, dateOfBirth, mail: String?
}

struct RegisterError : Codable {
    let status, message: String?
    let data: DataError
    let errorCode: Int?
}
struct DataError: Codable {
}
