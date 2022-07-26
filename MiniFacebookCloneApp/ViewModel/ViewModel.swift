//
//  ViewModel.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
class ViewModel
{
    let network = Networker()
    var getUserId : Int?
    func getUserIdInfo(){
        getUserId = UserDefaults.standard.integer(forKey: "keyId")
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
    
    func registerPassingData(userName : String ,password : String,dateOfbirth : String,email : String,gender : String, completion : @escaping(String)-> ())
    {
        network.userRegisteration(model: RegisterDetails(userName: userName, dateOfBirth: dateOfbirth, gender: gender, mail: email, userPassword: password)) { registerData in
            completion(registerData)
        }
    }
    func  loginPassing(mail : String, userPassword : String,completion : @escaping(String)-> ()){
        network.userLogin(model: LoginDetails(mail: mail, userPassword: userPassword)){ loginData in
            completion(loginData)
        }
    }
    var myResultObj = [DisplayFriendsData]()
    var suggestedFrdsResponseObj = [SuggestedFriendsData]()
    var getPostsObj = [GetPostsData]()
    func getDisplayFriendsData(completionHandler:@escaping(DisplayFriendsResponse)->Void)
    {
        getUserIdInfo()
        network.displayFriends(userId: self.getUserId ?? 0) { displayFrndsData in
            self.myResultObj = displayFrndsData.data
            
            completionHandler(displayFrndsData)
        }
    }
    func getSuggestedFrdsData(completionHandler:@escaping(SuggestedFriendsResponse)->Void)
    {
        network.suggestedFriends(userId: self.getUserId ?? 0) { suggestedFrndsData in
            self.suggestedFrdsResponseObj = suggestedFrndsData.data
            completionHandler(suggestedFrndsData)
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
        network.addNewFriend(addFrdobj: AddNewFriend(friendId: frdId, userId: userId)) { addFrndResult in
            completionHandler(addFrndResult)
        }
    }
    func deleteFrdDetails(friendId:Int,userId:Int,completionHandler:@escaping(Any)->Void)
    {
        network.deleteFriend(frdId: friendId, userId: userId) { deleteFrndData in
            completionHandler(deleteFrndData)
        }
    }
    var model1 : ProfileDetails?
    func profileDetails(completion: @escaping (ProfileDetails) -> ()){
        network.fetchingProfileData(userId: self.getUserId ?? 0) { profileDetailsResult in
            self.model1 = profileDetailsResult
            completion(profileDetailsResult)
        }
    }
    
    var createPostModelObj : CreatePostModel?
    var createresponseObj : Welcome?
    func PrintResponse(postData : String,completion: @escaping (String) -> ()) {
        network.createPost(requestObject: CreatePostModel(userId: getUserId ,postData: postData)) { createPostResult in
            completion(createPostResult)
        }
    }
    
    
    func updateDeletePost(userId :Int,postId : Int,completion : @escaping(DelPost)->()){
        network.delPost(userId: userId, postId: postId) { deletePostResult in
            completion(deletePostResult)
        }
    }
}
