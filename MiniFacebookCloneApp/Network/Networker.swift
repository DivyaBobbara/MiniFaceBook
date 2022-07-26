//
//  Network.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
class Networker{
    let baseUrl = "http://stagetao.gcf.education:3000/"
    let networkWorkingLayer = putApi()
    func updateLikes(userId:Int, postId:Int ,status:Bool, completionHandler : @escaping (UpdateLikes?,Error?) -> Void){
        
            guard let url = URL(string:"\(baseUrl)" + "\(urls.updateLikes.rawValue)\(postId)/\(userId)/\(status)") else{
                return
            }
        networkWorkingLayer.putMethodApiCalling(url: url) { (data, error) in
            completionHandler(data,error)
        }
        }
    func postData(model: Details,completion : @escaping (RegisterResponse?, Error?) -> Void){
        
        guard let url = URL(string: "\(baseUrl)\(urls.registerUrl.rawValue)")else
        {
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: model, completion: { (data, error) in
            completion(data, error)
            
        })
    }
    
    
    func logOutApiCall(userId:Int,completionHandler:@escaping(LogOutResponse?,Error?)->Void){
       
        guard let url = URL(string:"\(baseUrl)" + "\(urls.logOut.rawValue)\(userId)") else{
            return
        }
            networkWorkingLayer.putMethodApiCalling(url: url) { (data,error)  in
            
            completionHandler(data,error)
        
        }
       
    }
 
    func postingLoginData(model: LoginDetails,completion : @escaping (LoginResponse?,Error?) -> Void){
      
        guard let url = URL(string: "\(baseUrl)\(urls.loginUrl.rawValue)")else
        {
            return
        }
            networkWorkingLayer.postMethodApicalling(url: url, encode: model) { data,error  in
            completion(data,error)
        }
    }
    
    //-----
    func displayFriends(userId:Int,completionHandler:@escaping(DisplayFriendsResponse?,Error?)->Void){
        
        guard let url = URL(string:"\(baseUrl)\(urls.displayFriends.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url, completion: {
            data ,error in
            completionHandler(data,error)
            
        })
    }
    
    func suggestedFriends(userId:Int,completionHandler:@escaping(SuggestedFriendsResponse?,Error?)->Void){
        
        
        guard let url = URL(string: "\(baseUrl)\(urls.suggestFriends.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data,error in
            
            
            completionHandler(data,error)
        }
        
    }
    func getPosts(userId:Int,completionHandler:@escaping(GetPosts?,Error?)->Void){
        guard let url = URL(string:"\(baseUrl)\(urls.getPosts.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data,error in
            completionHandler(data,error)
            
        }
    }
    
    
    func addNewFriend(addFrdobj:NewFriendData,completionHandler:@escaping(AddNewFriend?,Error?)->Void){
        guard let url = URL(string: "\(baseUrl)\(urls.addNewFriend.rawValue)") else{
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: addFrdobj) { data, error in
            
            completionHandler(data,error)
        }
    }
    
    func deleteFriend(frdId:Int,userId:Int ,completionHandler:@escaping(DeleteFriend?,Error?)->Void) {
        guard let url = URL(string:"\(baseUrl)\(urls.deleteFriend.rawValue)\(frdId)/\(userId)") else {
            return
        }
        
        networkWorkingLayer.delMethodApiCalling(url: url) { data,error in completionHandler(data,error)
           
        }
    }
    
    //-------------
    func fetchingApidata(userId: Int,completion: @escaping(ProfileModel?,Error?)->()){
    
        guard let url = URL(string: "\(baseUrl)\(urls.displayUserProfile.rawValue)\(userId)") else{
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data,error in
            completion(data,error)
        }
    }
    
    func postPassword(userId: Int,model: Model, completion : @escaping(String) -> Void)
    {
        guard let url = URL(string: "\(baseUrl)\(urls.changePassword.rawValue)\(userId)")else
        {
            return
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.putMethod.rawValue
        do{
            let requestBody = try JSONEncoder().encode(model)
            request.httpBody = requestBody
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
        }
        catch
        {
            print("Not encoded")
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else {
                //                throw URLError(.badServerResponse)
                return
            }
            print(url,"inner")
            do{
                let responser = try JSONDecoder().decode(Response.self, from: data)
                let jString = String(data: data,encoding:.utf8)!
                print(jString)
                completion(jString)
            }
            catch{
                print("Error\(error.localizedDescription)")
            }
        }
        task.resume()
        
    }
    
    //    --------jhansi
    func updatingByTextFields(requestObject: CreatePostModel,completion: @escaping (Welcome?,Error?) -> Void) {
        let url = URL(string: "\(baseUrl)\(urls.createPost.rawValue)")
        guard let url = url else {
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: requestObject) { data,error  in
            completion(data,error)
            
           
        }
    }
    
    
    func delPost(userId : Int,postId : Int,completion : @escaping(DelPost?,Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(urls.deletePost.rawValue)\(userId)/\(postId)") else {
            return
        }
        print(url)
        networkWorkingLayer.delMethodApiCalling(url: url) { data,error in
            completion(data,error)
        }
        
    }
}




