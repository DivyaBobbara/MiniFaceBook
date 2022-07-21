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
    var getUserId : Int?
    func getUserIdInfo(){
         getUserId = UserDefaults.standard.integer(forKey: "keyId")
        print(getUserId)
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
    
    let networkManager = Networker()
    func getDisplayFriendsData(completionHandler:@escaping(DisplayFriendsResponse)->Void)
    {
        getUserIdInfo()
        
        networkManager.DisplayFriends(userId: self.getUserId ?? 0) { result in
//            print(result.data[0].userId)
            self.myResultObj = result.data
            completionHandler(result)
            
        }
        
        
    }
    func getSuggestedFrdsData(completionHandler:@escaping(SuggestedFriendsResponse)->Void)
    {
        networkManager.suggestedFriends(userId: self.getUserId ?? 0) { result in
            self.suggestedFrdsResponseObj = result.data
            completionHandler(result)
        }
    }
    func getPostDetails(completionHandler:@escaping(GetPosts)->Void)
    {
        print("post\(self.getUserId)")
        networkManager.getPosts(userId: self.getUserId ?? 0) { postResult in
            self.getPostsObj = postResult.data
//            print("PostResult\(postResult)")
            completionHandler(postResult)
        }
       
    }
    func postAddNewFriend(frdId:Int,userId:Int,completionHandler:@escaping(
    String)->Void)
    {
        networkManager.addNewFriend(addFrdobj: AddNewFriend(friendId: frdId, userId: userId)) { result in
            completionHandler(result)
        }
    }
    func deleteFrdDetails(friendId:Int,userId:Int,completionHandler:@escaping(Any)->Void)
    {
        networkManager.DeleteFriend(frdId: friendId, userId: userId) { res in
            print(res)
        completionHandler(res)
        }
    }
    
    
    
}
