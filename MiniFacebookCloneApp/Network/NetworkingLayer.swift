//
//  NetworkingLayer.swift
//  MiniFacebookCloneApp
//
//  Created by Jhansi Ch on 25/07/22.
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
class NetworkingLayer {
    let baseUrl = "http://stagetao.gcf.education:3000/"
    
    func putMethodApiCalling<T : Codable,U :Codable>(for attemp: Int, after seconds: Int, url:URL,encode : T?,completion : @escaping (U?,Error?)-> Void) {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.putMethod.rawValue
        if let encode = encode {
            do{
                let requestBody = try JSONEncoder().encode(encode)
                
                request.httpBody = requestBody
                request.setValue("application/json", forHTTPHeaderField: "Content-type")
            }
            catch
            {
                print("Not encoded")
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                if attemp <= 0 {
                    return completion(nil,error)
                }
                return self.putMethodApiCalling(for: attemp - 1, after: 5, url: url, encode: encode, completion: completion)
            }
            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else{
                if attemp <= 0 {
                    return
                }
                return self.putMethodApiCalling(for: attemp - 1, after: 5, url: url, encode: encode, completion: completion)
            }
            do{
                let model = try JSONDecoder().decode(U.self, from: data)
                completion(model,nil)
            }
            catch{
                print("errorr")
            }
        }
        task.resume()
        
    }
    
    func getMethodApiCalling <T : Decodable>(url : URL,completion : @escaping (T?,Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.getMethod.rawValue
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                return completion(nil,error)
            }
            
            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else {
                return
            }
            
            do{
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model,nil)
            }
            catch{
                print(error.localizedDescription)
            }
            
        }
        task.resume()
    }
    
    func postMethodApicalling <T : Encodable, U: Decodable> (url : URL,encode : T,completion : @escaping (U?, Error?) -> Void) {
        
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
                return completion(nil,error)
            }
            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else {
                return
            }
            do {
                let model = try JSONDecoder().decode(U.self, from: data)
                completion(model, nil)
            }
            catch{
                print("Error is because\(error.localizedDescription)")
            }
        }
        task.resume()
    }
    func delMethodApiCalling<T : Decodable>(url : URL,completion : @escaping (T?,Error?)->Void) {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethods.deleteMethod.rawValue
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data , error == nil else {
                return completion(nil,error)
            }
            guard let httpResponse = response as? HTTPURLResponse ,httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300 else {
                return
            }
            do{
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(model,nil)
                
            }
            catch {
                print("delete error is because\(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

    
