//
//  ViewModel.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
class ViewModel
{
    var getUserId : Int?
    func getUserIdInfo(){
        getUserId = UserDefaults.standard.integer(forKey: "keyId")
        print(getUserId)
    }
    func callUpdateLikes()
    {
        print("hiiooiii")
        network.updateLikes()
        
    }
    func callLogOutApi(completionHandler:@escaping(LogOutResponse)->Void)
    {
        network.logOutApiCall(userId: self.getUserId ?? 0) { LogOutResponse in
            completionHandler(LogOutResponse)
        }
    }
    
    
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
    // ----Divya---
    
    
    
    var myResultObj = [MyResult]()
    var suggestedFrdsResponseObj = [MyResult1]()
    var getPostsObj = [MyResult2]()
    func getDisplayFriendsData(completionHandler:@escaping(DisplayFriendsResponse)->Void)
    {
        getUserIdInfo()
        network.DisplayFriends(userId: self.getUserId ?? 0) { result in
            //            print(result.data[0].userId)
            self.myResultObj = result.data
            
            completionHandler(result)
        }
    }
    func getSuggestedFrdsData(completionHandler:@escaping(SuggestedFriendsResponse)->Void)
    {
        network.suggestedFriends(userId: self.getUserId ?? 0) { result in
            self.suggestedFrdsResponseObj = result.data
            completionHandler(result)
        }
    }
    var postObj1 : GetPosts?
//    var model2 = [MyResult2]()
    func getPostDetails(completionHandler:@escaping(GetPosts)->Void)
    {
//        print("post\(self.getUserId)")
        network.getPosts(userId: self.getUserId ?? 0) { postResult in
            self.getPostsObj = postResult.data
            completionHandler(postResult)
            //            print("PostResult\(postResult)")
        }
    }
    func postAddNewFriend(frdId:Int,userId:Int,completionHandler:@escaping(
        String)->Void)
    {
        network.addNewFriend(addFrdobj: AddNewFriend(friendId: frdId, userId: userId)) { result in
            completionHandler(result)
        }
    }
    func deleteFrdDetails(friendId:Int,userId:Int,completionHandler:@escaping(Any)->Void)
    {
        network.DeleteFriend(frdId: friendId, userId: userId) { res in
            print(res)
            completionHandler(res)
        }
    }
    var model1 : ProfileDetails?
    func ProfileDetails(completion: @escaping (ProfileDetails) -> ()){
        print(self.getUserId,"vgduqqgdugdu")
        network.fetchingApidata(userId: self.getUserId ?? 0) { result in
            self.model1 = result
            print(result,"dfugdiquhdsjuaqb")
            completion(result)
        }
    }
    let createPostNetwork = Networker()
     var createPostModelObj : CreatePostModel?
     var createresponseObj : Welcome?
     func PrintResponse(postData : String,completion: @escaping (String) -> ()) {
         createPostNetwork.UpdatingByTextFields(requestObject: CreatePostModel( userId: getUserId, postData: postData)) { result in
         print(result)
         completion(result)
       }
     }
    
    
    
    
}
