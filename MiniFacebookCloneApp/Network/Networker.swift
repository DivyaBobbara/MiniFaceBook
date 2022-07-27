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
        networkWorkingLayer.putMethodApiCalling(url: url) { (data, error) in
            completionHandler(data,error)
        }
    }
    
    func register(model: RegisterModel,completion : @escaping (RegisterResponse?, Error?) -> Void){
        
        guard let url = URL(string: "\(baseUrl)\(urls.registerUrl.rawValue)")else
        {
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: model, completion: { (data, error) in
            completion(data, error)
        })
    }
    
    
    func logOut(userId:Int,completionHandler:@escaping(LogOutResponse?,Error?)->Void){
        
        guard let url = URL(string:"\(baseUrl)" + "\(urls.logOut.rawValue)\(userId)") else{
            return
        }
        networkWorkingLayer.putMethodApiCalling(url: url) { (data,error)  in
            completionHandler(data,error)
        }
        
    }
    
    func login(model: LoginRequest,completion : @escaping (LoginResponse?,Error?) -> Void){
        
        guard let url = URL(string: "\(baseUrl)\(urls.loginUrl.rawValue)")else
        {
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: model) { data,error  in
            completion(data,error)
        }
    }
    
    func displayFriends (userId : Int,completionHandler : @escaping (DisplayFriendsResponse?,Error?)->Void){
        
        guard let url = URL(string:"\(baseUrl)\(urls.displayFriends.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url, completion: {
            data ,error in
            completionHandler(data,error)
        })
    }
    
    func suggestedFriends(userId : Int, completionHandler : @escaping (SuggestedFriendsResponse?,Error?) -> Void){
        
        
        guard let url = URL(string: "\(baseUrl)\(urls.suggestFriends.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data,error in
            completionHandler(data,error)
        }
    }
    
    func getPosts(userId:Int,completionHandler:@escaping(GetPostsModel?,Error?)->Void){
        guard let url = URL(string:"\(baseUrl)\(urls.getPosts.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data,error in
            completionHandler(data,error)
        }
    }
    
    func addNewFriend(addFrdobj : AddNewFriendModel,completionHandler : @escaping (AddNewFriendResponse?,Error?)->Void){
        guard let url = URL(string: "\(baseUrl)\(urls.addNewFriend.rawValue)") else{
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: addFrdobj) { data, error in
            completionHandler(data,error)
        }
    }
    
    func deleteFriend(frdId:Int,userId:Int ,completionHandler:@escaping(DeleteFriendModel?,Error?)->Void) {
        guard let url = URL(string:"\(baseUrl)\(urls.deleteFriend.rawValue)\(frdId)/\(userId)") else {
            return
        }
        networkWorkingLayer.delMethodApiCalling(url: url) { data,error in completionHandler(data,error)
        }
    }
    
    func displayProfile(userId: Int,completion: @escaping(ProfileModel?,Error?)->()){
        
        guard let url = URL(string: "\(baseUrl)\(urls.displayUserProfile.rawValue)\(userId)") else{
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data,error in
            completion(data,error)
        }
    }
    
    func changePassword(userId: Int,model: ChangePasswordRequest, completion : @escaping(String) -> Void)
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
            
            do{
                let responser = try JSONDecoder().decode(ChangePasswordResponse.self, from: data)
                let jString = String(data: data,encoding:.utf8)!
                completion(jString)
            }
            catch{
                print("Error\(error.localizedDescription)")
            }
        }
        task.resume()
    }
    

    func createPost(requestObject: CreatePostModel,completion: @escaping (CreatePostResponse?,Error?) -> Void) {
        let url = URL(string: "\(baseUrl)\(urls.createPost.rawValue)")
        guard let url = url else {
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: requestObject) { data,error  in
            completion(data,error)
        }
    }
    
    
    func delPost(userId : Int,postId : Int,completion : @escaping(DelPostModel?,Error?) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(urls.deletePost.rawValue)\(userId)/\(postId)") else {
            return
        }
        networkWorkingLayer.delMethodApiCalling(url: url) { data,error in
            completion(data,error)
        }
    }
}




