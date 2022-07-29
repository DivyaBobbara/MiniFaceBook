//
//  ViewModel.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
import UIKit
class ViewModel
{
    static let shared : ViewModel = ViewModel()
    let network = Networker()
    var registerResponse: RegisterResponse?
    var updateResponse : UpdateLikesModel?
    var logoutResponse : LogOutResponse?
    var loginresponse : LoginResponse?
    var displayFrndsResponse : DisplayFriendsResponse?
    var displayFrndsResponseData = [DisplayFriendsData]()
    var suggestedFrndsResponse : SuggestedFriendsResponse?
    var suggestedFrndsResponseData = [SuggestedFriendsData]()
    var getPostsResponse : GetPostsModel?
    var addNewFrndResponse : AddNewFriendResponse?
    var deleteFrndResponse : DeleteFriendModel?
    var profileDetailsResponse : ProfileModel?
    var profileDetailsDataResponse : ProfileDetails?
    var creataPostResponse : CreatePostResponse?
    var deleteResponse : DelPostModel?
    var changePasswordresponse : ChangePasswordResponse?
    
    var getUserId : Int?
    
    func getUserIdInfo(){
        getUserId = UserDefaults.standard.integer(forKey: "keyId")
//        print(getUserId)
    }
    func callUpdateLikes(getUserId:Int,getPostId:Int,getStatus:Bool,completionHandler:@escaping(Error?)->Void)
    {
        network.updateLikes(userId: getUserId, postId: getPostId, status: getStatus) { result,error   in
            self.updateResponse = result
            completionHandler(error)
        }
    }
    
    func callLogOut(completionHandler:@escaping(Error?)->Void)
    {
        network.logOut(userId: self.getUserId ?? 0) { result,error   in
            self.logoutResponse = result
            completionHandler(error)
        }
    }
    func callRegister(userName : String ,password : String,dateOfbirth : String,email : String,gender : String, completion : @escaping(Error?)-> ())
    {
        network.register(model: RegisterModel(userName: userName, dateOfBirth: dateOfbirth, gender: gender, mail: email, userPassword: password)) { result, error in
            self.registerResponse = result
            completion(error)
        }
    }
    func  callLogin(mail : String, userPassword : String ,completion : @escaping(Error?)-> ()){
        network.login(model: LoginRequest(mail: mail, userPassword: userPassword)){
            result,error in
            self.loginresponse = result
            completion(error)
        }
    }
    func getDisplayFriendsData(completionHandler:@escaping(Error?)->Void)
    {
        getUserIdInfo()
        network.displayFriends(userId: self.getUserId ?? 0) { result,error in
            guard let result = result else {
                return
            }
            self.displayFrndsResponseData = result.data
            
            completionHandler(error)
        }
    }
    func getSuggestedFrdsData(completionHandler:@escaping(Error?)->Void)
    {
        getUserIdInfo()
        network.suggestedFriends(userId: self.getUserId ?? 0) { result,error in
            
            guard let result = result else {
                return
            }
            self.suggestedFrndsResponseData = result.data
            completionHandler(error)
        }
    }
    
    func getPostDetails(completionHandler:@escaping(Error?)->Void)
    {
        network.getPosts(userId: self.getUserId ?? 0) {result,error in
            self.getPostsResponse = result
            completionHandler(error)
        }
    }
    func callAddNewFriend(frdId:Int,userId:Int,completionHandler:@escaping(
        Error?)->Void)
    {
        network.addNewFriend(addFrdobj: AddNewFriendModel(friendId: frdId, userId: userId)) { result,error in
            self.addNewFrndResponse = result
            completionHandler(error)
        }
    }
    func deleteFrdDetails(friendId:Int,userId:Int,completionHandler:@escaping(Error?)->Void)
    {
        network.deleteFriend(frdId: friendId, userId: userId) { result,error in
            self.deleteFrndResponse = result
            completionHandler(error)
        }
    }
    
    func getProfileDetails(completion: @escaping (Error?) -> ()){
        network.displayProfile(userId: self.getUserId ?? 0) { result,error in
            self.profileDetailsDataResponse = result?.data
            completion(error)
        }
    }
    
    
    func callCreatePost(postData : String,completion: @escaping (Error?) -> ()) {
        network.createPost(requestObject: CreatePostModel(userId: getUserId ,postData: postData)) { result,error in
            self.creataPostResponse = result
            completion(error)
        }
    }
    
    
    func callDeletePost(userId :Int,postId : Int,completion : @escaping(Error?)->()){
        network.delPost(userId: userId, postId: postId) { result,error in
            self.deleteResponse = result
            completion(error)
        }
    }
    func callChangePassword(newPassword : String?,confirmPassword: String?,completion : @escaping(Error?)->()) {
        
        network.changePassword(userId: getUserId ?? 0, model: ChangePasswordRequest(newPassword: newPassword, confirmPassword: confirmPassword)) { result, error in
            self.changePasswordresponse = result
            completion(error)
        }
    }
}



