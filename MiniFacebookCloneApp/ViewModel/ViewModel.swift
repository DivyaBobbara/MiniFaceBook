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
    func callUpdateLikes(getUserId:Int,getPostId:Int,getStatus:Bool,completionHandler:@escaping(UpdateLikes)->Void)
    {
        network.updateLikes(userId: getUserId, postId: getPostId, status: getStatus) { updateLikesResponse in
            completionHandler(updateLikesResponse)
        }
        
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
        network.userRegisteration(model: Details(userName: userName, dateOfBirth: dateOfbirth, gender: gender, mail: email, userPassword: password)) { result in
            completion(result)
        }
    }
    func  loginPassing(mail : String, userPassword : String ,completion : @escaping(String)-> ()){
        network.userLogin(model: LoginDetails(mail: mail, userPassword: userPassword)){ result in
            completion(result)
        }
    }
    // -------------
    var myResultObj = [MyResult]()
    var suggestedFrdsResponseObj = [MyResult1]()
    var getPostsObj = [MyResult2]()
    func getDisplayFriendsData(completionHandler:@escaping(DisplayFriendsResponse)->Void)
    {
        getUserIdInfo()
        network.displayFriends(userId: self.getUserId ?? 0) { result in
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
    func getPostDetails(completionHandler:@escaping(GetPosts)->Void)
    {
        network.getPosts(userId: self.getUserId ?? 0) { postResult in
            self.getPostsObj = postResult.data
            completionHandler(postResult)
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
        network.deleteFriend(frdId: friendId, userId: userId) { res in
            print(res)
            completionHandler(res)
        }
    }
    var model1 : ProfileDetails?
    func profileDetails(completion: @escaping (ProfileDetails) -> ()){
        network.fetchingProfileData(userId: self.getUserId ?? 0) { result in
            self.model1 = result
            completion(result)
        }
    }
    
    var createPostModelObj : CreatePostModel?
    var createresponseObj : Welcome?
    func PrintResponse(postData : String,completion: @escaping (String) -> ()) {
        network.createPost(requestObject: CreatePostModel(userId: getUserId ,postData: postData)) { result in
            completion(result)
        }
    }
    
    
    func updateDeletePost(userId :Int,postId : Int,completion : @escaping(DelPost)->()){
        network.delPost(userId: userId, postId: postId) { result in
            completion(result)
        }
    }
}
