//
//  NetworkLayer.swift
//  MiniFacebookCloneApp
//
//  Created by Ramya Oduri on 25/07/22.
//

import Foundation
enum urls : String {
    case loginUrl = "api/v1/login"
    case registerUrl = "api/v1/register"
    case displayUserProfile = "api/v1/profile/"
    case changePassword = "api/v1/changePassword/"
    case getPosts = "api/v1/posts/"
    case createPost = "api/v1/post"
    case deletePost = "api/v1/post/"
    case updateLikes = "api/v1/postLikes/"
    case displayFriends = "api/v1/userFriends/"
    case addNewFriend = "api/v1/friend"
    case deleteFriend = "api/v1/friend/"
    case logOut = "api/v1/logout/2"
    case suggestFriends = "api/v1/suggestFriends/"
    
}
enum httpMethods : String {
    case getMethod = "GET"
    case postMethod = "POST"
    case putMethod = "PUT"
    case deleteMethod = "DELETE"
}
class putApi {
    
    func putMethodApiCalling(url:URL,completion : @escaping (Data)-> Void) {
        var request = URLRequest(url: url)
        
        request.httpMethod = httpMethods.putMethod.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else {
                return
            }
            completion(data)
        }
        task.resume()
        
    }
    
    func getMethodApiCalling(url : URL,completion : @escaping (Data) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.getMethod.rawValue
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else {
                //        throw URLError(.badServerResponse)
                return
            }
            completion(data)
        }
        task.resume()
    }
    func delMethodApiCalling(url : URL,completion : @escaping (Data)->Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.deleteMethod.rawValue
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else {
                //        throw URLError(.badServerResponse)
                return
            }
            completion(data)
        }
        task.resume()
    }
    func postMethodApicalling <T : Codable> (url : URL,encode : T,completion : @escaping (Data) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.postMethod.rawValue
        do{
            let requestBody = try JSONEncoder().encode(encode)
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
                //        throw URLError(.badServerResponse)
                return
            }
            completion(data)
        }
        task.resume()
    }
}
