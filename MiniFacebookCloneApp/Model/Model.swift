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
    let status ,message : String?
    let data : [MyResult2]
    let errorCode : String?
}
struct MyResult2 : Codable{
    let postId : Int?
    let userName : String?
    let postData : String?
    let totalLikes : Int?
    let likeStatus : Bool?
    let iscreated : String?
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


//-----ramya
struct ProfileModel: Codable {
    let status, message: String?
    let data: ProfileDetails
    let errorCode: String?
}
struct ProfileDetails : Codable {
    let userId: Int?
    let userName, mail, dateOfBirth, gender: String?
    let loginStatus: Bool?
}

struct ErrorModel : Codable {
    let status : String?
    let message : String?
    let data : String?
    let errorCode : String?
}



struct Model : Codable {
    let newPassword : String?
    let confirmPassword : String?
}

struct Response : Codable {
    let status : String?
    let message : String?
    let data : responseData
    let errorCode : String?
}
struct responseData : Codable{
    
}

struct ErrorMessage : Codable{
    let status : String?
    let message : String?
    let data : ErrorData
    let errorCode : Int?
}
struct ErrorData : Codable{
    
}

//-------Jhansi

struct CreatePostModel : Codable {
  let userId : Int?
  let postData : String?
}
struct Welcome: Codable {
  let status, message: String?
  let data: DataClasses?
  let errorCode: String?
}
struct DataClasses: Codable {
  let userID: Int?
  let postData: String?

  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case postData
  }
}

struct DelPost : Codable {
  let status : String?
  let message : String?
  let data : DataPostId
  let errorCode : String?
}
struct DataPostId : Codable {
  let userId : Int?
  let postId : Int?
}
struct UpdateLikes : Codable{
    let status : String?
    let message : String?
    let data : UpdateLikesStatus
    let errorCode : String?
}
struct UpdateLikesStatus : Codable{
    let likeStatus : String?
    let count: String?
}

struct LogOutResponse : Codable{
    let status : String?
    let message : String?
    let data : LogOutStatus
    let errorCode : String?
}
struct LogOutStatus : Codable{
    let userId : String?
    let loginStatus : Bool?
}
