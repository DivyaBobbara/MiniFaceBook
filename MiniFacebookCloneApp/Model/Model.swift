//
//  Model.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
struct RegisterModel : Codable {
    let userName, dateOfBirth, gender, mail: String?
    let userPassword: String?
}
struct LoginRequest: Codable {
    let mail, userPassword: String?
}
struct LoginResponse : Codable {
    let status, message: String?
    let data: LoginResponseData?
    let errorCode: Int?
}
struct LoginResponseData: Codable {
    let userId : Int?
    let loginStatus: Bool?
}
struct RegisterResponse: Codable {
    let status, message: String?
    let data: RegisterResponseData
    let errorCode: Int?
}
struct RegisterResponseData: Codable {
    let userName, gender, dateOfBirth, mail: String?
}
struct DisplayFriendsResponse:Codable{
    let status : String?
    let message : String?
    let data : [DisplayFriendsData]
    let errorCode : String?
 
}
struct DisplayFriendsData:Codable{
    let userId : Int?
    let userName : String?
}
struct SuggestedFriendsResponse : Codable{
    let data : [SuggestedFriendsData]
    
}
struct SuggestedFriendsData : Codable{
    let friendId : Int?
    let friendName : String?
}
struct GetPostsModel:Codable{
    let status ,message : String?
    let data : [GetPostData]
    let errorCode : String?
}
struct GetPostData : Codable{
    let postId : Int?
    let userName : String?
    let postData : String?
    let totalLikes : Int?
    let likeStatus : Bool?
    let iscreated : String?
    let userId : Int?
}

struct AddNewFriendResponse : Codable{
    
    var message : String?
    var status : String?
    var data : AddNewFriendsData?
    var errorCode : Int?
   
}
struct AddNewFriendsData : Codable{
    let friendId : Int?
    let userId : Int?
}
struct AddNewFriendModel : Codable{
    let friendId : Int?
    let userId : Int?
}


struct DeleteFriendModel : Codable {
    let status : String?
    let message : String?
    let data : FriendId
    let errorCode : String?
}
struct FriendId : Codable {
    let friendId : String?
}
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



struct ChangePasswordRequest : Codable {
    let newPassword : String?
    let confirmPassword : String?
}

struct ChangePasswordResponse : Codable {
    let status : String?
    let message : String?
    let data : ChangePasswrdResponseData
    let errorCode : String?
}
struct ChangePasswrdResponseData : Codable{
    
}


struct CreatePostModel : Codable {
  let userId : Int?
  let postData : String?
}
struct CreatePostResponse: Codable {
  let status, message: String?
  let data: CreatePostData
  let errorCode: String?
}
struct CreatePostData: Codable {
  let userID: Int?
  let postData: String?

  enum CodingKeys: String, CodingKey {
    case userID = "userId"
    case postData
  }
}

struct DelPostModel : Codable {
  let status : String?
  let message : String?
  let data : DeletePostIds
  let errorCode : String?
}
struct DeletePostIds : Codable {
  let userId : String?
  let postId : String?
}
struct UpdateLikesModel : Codable{
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
