//
//  Network.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
class Networker{
    
    let baseUrl = "http://stagetao.gcf.education:3000/"
    
    let networkWorkingLayer = NetworkingLayer()
    
    func updateLikes(userId:Int, postId:Int ,status:Bool, completionHandler : @escaping (UpdateLikesModel?,Error?) -> Void){
        guard let url = URL(string:"\(baseUrl)" + "\(urls.updateLikes.rawValue)\(postId)/\(userId)/\(status)") else{
            return
        }
        networkWorkingLayer.putMethodApiCalling(for: 5,url: url, encode: nil as ChangePasswordRequest?) { (data, error) in
            completionHandler(data,error)
        }
    }
    
    func register(model: RegisterModel,completion : @escaping (RegisterResponse?, Error?) -> Void){
        
        guard let url = URL(string: "\(baseUrl)\(urls.registerUrl.rawValue)")else
        {
            return
        }
        networkWorkingLayer.postMethodApicalling(for: 5,url: url, encode: model , completion: { (data, error) in
            completion(data, error)
        })
    }
    
    
    func logOut(userId:Int,completionHandler:@escaping(LogOutResponse?,Error?)->Void){
        
        guard let url = URL(string:"\(baseUrl)" + "\(urls.logOut.rawValue)\(userId)") else{
            return
        }
        networkWorkingLayer.putMethodApiCalling(for: 5,url: url, encode: nil as ChangePasswordRequest?) { (data,error)  in
            completionHandler(data,error)
        }
        
    }
    
    func login(model: LoginRequest,completion : @escaping (LoginResponse?,Error?) -> Void){
        
        guard let url = URL(string: "\(baseUrl)\(urls.loginUrl.rawValue)")else
        {
            return
        }
        networkWorkingLayer.postMethodApicalling(for: 5,url: url, encode: model,completion:  { data,error  in
            completion(data,error)
        })
    }
    
    func displayFriends (userId : Int,completionHandler : @escaping (DisplayFriendsResponse?,Error?)->Void){
        
        guard let url = URL(string:"\(baseUrl)\(urls.displayFriends.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(for: 5,url: url, completion: {
            data ,error in
            completionHandler(data,error)
        })
    }
    
    func suggestedFriends(userId : Int, completionHandler : @escaping (SuggestedFriendsResponse?,Error?) -> Void){
        
        
        guard let url = URL(string: "\(baseUrl)\(urls.suggestFriends.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(for: 5,url: url,completion:  { data,error in
            completionHandler(data,error)
        })
    }
    
    func getPosts(userId:Int,completionHandler:@escaping(GetPostsModel?,Error?)->Void){
        guard let url = URL(string:"\(baseUrl)\(urls.getPosts.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(for: 5,url: url,completion:  { data,error in
            completionHandler(data,error)
        })
    }
    
    func addNewFriend(addFrdobj : AddNewFriendModel,completionHandler : @escaping (AddNewFriendResponse?,Error?)->Void){
        guard let url = URL(string: "\(baseUrl)\(urls.addNewFriend.rawValue)") else{
            return
        }
        networkWorkingLayer.postMethodApicalling(for: 5,url: url, encode: addFrdobj,completion: { data, error in
            completionHandler(data,error)
        })
    }
    
    func deleteFriend(frdId:Int,userId:Int ,completionHandler:@escaping(DeleteFriendModel?,Error?)->Void) {
        guard let url = URL(string:"\(baseUrl)\(urls.deleteFriend.rawValue)\(frdId)/\(userId)") else {
            return
        }
        networkWorkingLayer.delMethodApiCalling(for: 5,url: url) { data,error in completionHandler(data,error)
        }
    }
    
    func displayProfile(userId: Int,completion: @escaping(ProfileModel?,Error?)->()){
        
        guard let url = URL(string: "\(baseUrl)\(urls.displayUserProfile.rawValue)\(userId)") else{
            return
        }
        networkWorkingLayer.getMethodApiCalling(for: 5,url: url) { data,error in
            completion(data,error)
        }
    }
    
    func changePassword(userId: Int,model: ChangePasswordRequest, completion : @escaping(ChangePasswordResponse?,Error?) -> Void)
    {
        guard let url = URL(string: "\(baseUrl)\(urls.changePassword.rawValue)\(userId)")else
        {
            return
        }
        networkWorkingLayer.putMethodApiCalling(for: 5, url: url, encode: model) { data, error in
            completion(data,error)
        }
    }
    
    
    func createPost(requestObject: CreatePostModel,completion: @escaping (CreatePostResponse?,Error?) -> Void) {
        let url = URL(string: "\(baseUrl)\(urls.createPost.rawValue)")
        guard let url = url else {
            return
        }
        networkWorkingLayer.postMethodApicalling(for: 5,url: url, encode: requestObject) { data,error  in
            completion(data,error)
        }
    }
    
    
    func delPost(userId : Int,postId : Int,completion : @escaping(DelPostModel?,Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(urls.deletePost.rawValue)\(userId)/\(postId)") else {
            return
        }
        networkWorkingLayer.delMethodApiCalling(for: 5,url: url) { data,error in
            completion(data,error)
        }
    }
}




