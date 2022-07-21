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

//-----Divya------//
struct DisplayFriendsResponse:Codable{
    let status : String?
    let message : String?
    let data : [MyResult]
    let errorCode : String?
 
}
struct MyResult:Codable{
    let userId : Int?
    let userName : String?
}
struct SuggestedFriendsResponse : Codable{
    let data : [MyResult1]
    
}
struct MyResult1 : Codable{
    let friendId : Int?
    let friendName : String?
}
struct GetPosts:Codable{
    let data : [MyResult2]
    let errorCode : String?
    
}
struct MyResult2 : Codable{
    let userName : String?
    let postData : String?
    let totalLikes : Int?
    let likeStatus : Bool?
    let isCreated : Bool?
    let userId : Int?
}

struct AddNewFriend : Codable{
    let friendId : Int
    let userId : Int
    var message : String?
    var status : String?
    var data : [NewFriendData]?
    var errorCode : String?
    
    init(friendId:Int,userId:Int){
        self.friendId = friendId
        self.userId = userId
    }
}
struct NewFriendData : Codable{
    let friendId : Int?
    let userId : Int?
}
//{
//  "status": "client error",
//  "message": {
//    "text": "bad request",
//    "error": "Validation error"
//  },
//  "data": "",
//  "errorCode": 400
//}
struct BadRequestAddNewFriend : Codable{
    let status : String?
    let message : [ErrorMessages]?
    let data : String?
    let errorCode : Int?
}
struct ErrorMessages : Codable{
    let text : String?
    let error : String?
}
