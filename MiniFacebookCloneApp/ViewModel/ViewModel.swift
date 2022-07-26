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
    let network = Networker()
    var registerResponse: RegisterResponse?
    var resgisterErrorResponse : RegisterError?
    var updateResponse : UpdateLikes?
    var logoutResponse : LogOutResponse?
    var loginresponse : LoginResponse?
    var displayFrndsResponse : DisplayFriendsResponse?
    var displayFrndsResponseData = [DisplayFriendsData]()
    var suggestedFrndsResponse : SuggestedFriendsResponse?
    var suggestedFrndsResponseData = [SuggestedFriendsData]()
    var getPostsResponse : GetPosts?
    var addNewFrndResponse : AddNewFriend?
    var deleteFrndResponse : DeleteFriend?
    var profileDetailsResponse : ProfileModel?
    var profileDetailsDataResponse : ProfileDetails?
    var creataPostResponse : Welcome?
    var deleteResponse : DelPost?
    var getUserId : Int?
    func getUserIdInfo(){
        getUserId = UserDefaults.standard.integer(forKey: "keyId")
        print(getUserId)
    }
    func callUpdateLikes(getUserId:Int,getPostId:Int,getStatus:Bool,completionHandler:@escaping(Error?)->Void)
    {
        network.updateLikes(userId: getUserId, postId: getPostId, status: getStatus) { result,error   in
            self.updateResponse = result
            completionHandler(error)
        }
    }
    
    func callLogOutApi(completionHandler:@escaping(Error?)->Void)
    {
        network.logOutApiCall(userId: self.getUserId ?? 0) { result,error   in
            self.logoutResponse = result
            completionHandler(error)
        }
    }
    func passingData(userName : String ,password : String,dateOfbirth : String,email : String,gender : String, completion : @escaping(Error?)-> ())
    {
        network.postData(model: Details(userName: userName, dateOfBirth: dateOfbirth, gender: gender, mail: email, userPassword: password)) { result, error in
            self.registerResponse = result
            completion(error)
        }
    }
    func  loginPassing(mail : String, userPassword : String ,completion : @escaping(Error?)-> ()){
        network.postingLoginData(model: LoginDetails(mail: mail, userPassword: userPassword)){
            result,error in
            self.loginresponse = result
            completion(error)
        }
    }
    // -------------
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
    func postAddNewFriend(frdId:Int,userId:Int,completionHandler:@escaping(
        Error?)->Void)
    {
        network.addNewFriend(addFrdobj: NewFriendData(friendId: frdId, userId: userId)) { result,error in
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
    
    func profileDetails(completion: @escaping (Error?) -> ()){
        network.fetchingApidata(userId: self.getUserId ?? 0) { result,error in
            self.profileDetailsDataResponse = result?.data
            completion(error)
        }
    }
    
    
    func PrintResponse(postData : String,completion: @escaping (Error?) -> ()) {
        network.updatingByTextFields(requestObject: CreatePostModel(userId: getUserId ,postData: postData)) { result,error in
            self.creataPostResponse = result
            completion(error)
        }
    }
    
    
    func updateDeletePost(userId :Int,postId : Int,completion : @escaping(Error?)->()){
        network.delPost(userId: userId, postId: postId) { result,error in
            self.deleteResponse = result
            completion(error)
        }
    }
}



