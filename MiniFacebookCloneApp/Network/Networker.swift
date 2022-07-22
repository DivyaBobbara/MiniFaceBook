//
//  Network.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
class Networker{

    func updateLikes(){
        print("update")
        guard let url = URL(string:"http://stagetao.gcf.education:3000/api/v1/postLikes/1/29/false") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data , error == nil else {
                
                return
            }
            
            var updateLikesResponse : UpdateLikes?
            do{
                
                updateLikesResponse = try JSONDecoder().decode(UpdateLikes.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }

            print("res\(updateLikesResponse?.data)")
        }
        task.resume()
        
        
    }
    
    func logOutApiCall(userId:Int,completionHandler:@escaping(LogOutResponse)->Void){
        guard let url = URL(string:"http://stagetao.gcf.education:3000/api/v1/logout/"+"\(userId)") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data , error == nil else {
                
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            var res : LogOutResponse?
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
            
            do{
                
                res = try JSONDecoder().decode(LogOutResponse.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }
           
            

//            print("res\(res)")
            completionHandler(res!)
            }
           
                
            
        }
        task.resume()
        
        
        
    }

    
    func postData(model: Details,completion : @escaping (String) -> Void){
    guard let url = URL(string: "http://stagetao.gcf.education:3000/api/v1/register")else
    {
        return
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    do{
        let requestBody = try JSONEncoder().encode(model)
        request.httpBody = requestBody
        request.setValue("application/json", forHTTPHeaderField: "Content-type")
    }
    catch
    {
        print("E")
    }
    let task = URLSession.shared.dataTask(with: request ){ data ,response, error in
    guard let data = data ,error == nil else{
        return
    }
    do{
       
//        let responser = try JSONDecoder().decode(Details.self, from: data)
        let jsonString = try JSONSerialization.jsonObject(with: data)
      print("Success:\(jsonString)")
        let jString = String(data: data, encoding: .utf8)!
        completion(jString)
    }
    catch{
        print("Error")
    }
    }
    task.resume()
    }
    func postingLoginData(model: LoginDetails,completion : @escaping (String) -> Void){
        guard let url = URL(string: "http://stagetao.gcf.education:3000/api/v1/login")else
        {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do{
            let requestBody = try JSONEncoder().encode(model)
            request.httpBody = requestBody
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
        }
        catch
        {
            print("E")
        }
        let task = URLSession.shared.dataTask(with: request ){ data ,response, error in
        guard let data = data ,error == nil else{
            return
        }
        do{
//          let responser = try JSONDecoder().decode(LoginDetails.self, from: data)
            let jsonString = try JSONSerialization.jsonObject(with: data)
            let jString = String(data: data, encoding: .utf8)!
          print("Success:\(jString)")
            completion(jString)
        }
        catch{
            print("Error")
        }
        }
        task.resume()
        }
    
    
    //-----
    func DisplayFriends(userId:Int,completionHandler:@escaping(DisplayFriendsResponse)->Void){
        print("display\(userId)")
        let url = "http://stagetao.gcf.education:3000/api/v1/userFriends/"+"\(userId)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data , error == nil else {
                print("something went wrong")
                return
            }
            var result : DisplayFriendsResponse?
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
            do{
                result = try JSONDecoder().decode(DisplayFriendsResponse.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }
            }
            guard let json = result else{
                return
            }
//            print(json.status)
            completionHandler(json)
            
        })
        task.resume()
        
        
    }
    func suggestedFriends(userId:Int,completionHandler:@escaping(SuggestedFriendsResponse)->Void){
        
        let url = "http://stagetao.gcf.education:3000/api/v1/suggestFriends/"+"\(userId)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!,completionHandler:  { data, response, error in
            guard let data = data , error == nil else {
                print("something went wrong")
                return
            }
            var result : SuggestedFriendsResponse?
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
            do{
                result = try JSONDecoder().decode(SuggestedFriendsResponse.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }
            }
//            print("\(result)")
            guard let json = result else{
                return
            }
//            print(result)
            completionHandler(json)

            
        })
        task.resume()
        
    }
    func getPosts(userId:Int,completionHandler:@escaping(GetPosts)->Void){
        let url = "http://stagetao.gcf.education:3000/api/v1/posts/"+"\(userId)"
        let task = URLSession.shared.dataTask(with: URL(string: url)!,completionHandler:  { data, response, error in
            guard let data = data , error == nil else {
                print("something went wrong")
                return
            }
            var result : GetPosts?
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            if httpResponse.statusCode >= 200 && httpResponse.statusCode <= 300{
            do{
                result = try? JSONDecoder().decode(GetPosts.self, from: data)
//                let jString = String(data: data, encoding: .utf8)!
//                completionHandler(jString)
                DispatchQueue.main.async {
                    completionHandler(result!)
                }
                
            }
            catch{
                print(error.localizedDescription)
            }
            }
//            print(result)
            guard let json = result else{
                return
            }
//            completionHandler(json)

            
        })
        task.resume()
        
    }
    func addNewFriend(addFrdobj:AddNewFriend,completionHandler:@escaping(String)->Void){
        guard let url = URL(string: "http://stagetao.gcf.education:3000/api/v1/friend") else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        let body = AddNewFriend(friendId: 16, userId: 1)
        let jsonData = try? JSONEncoder().encode(addFrdobj)
        request.httpBody = jsonData
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            if httpResponse.statusCode >= 200 && httpResponse.statusCode<300{
            do{
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data) else{
                    return
                }
                let jsonString = String(data: data, encoding: .utf8)
                completionHandler(jsonString ?? "")
                
            }
            catch{
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
        
    }
   
    func DeleteFriend(frdId:Int,userId:Int ,completionHandler:@escaping(Any)->Void) {
        let url = "http://stagetao.gcf.education:3000/api/v1/friend/"+"\(frdId)/\(userId)"
        
        guard let url = URL(string: url) else{
            print("something went wrong")
            return
        }
        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data , error == nil else {
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else{
                return
            }
            if httpResponse.statusCode >= 200 && httpResponse.statusCode < 300{
                do{
                    guard let jsonObj = try? JSONSerialization.jsonObject(with: data) as? [String:Any] else{
                        return
                    }
                    guard let prettyJson = try? JSONSerialization.data(withJSONObject: jsonObj, options: .prettyPrinted) else{
                        return
                    }
                    guard let prettyPrintedJson = String(data: prettyJson, encoding: .utf8) else{
                        return
                    }
//                    print(prettyPrintedJson)
                    completionHandler(jsonObj)


                }
                catch{
                    print(error.localizedDescription)
                }
            }

        }
        task.resume()

    }
    
    //-------------
    func fetchingApidata(userId: Int,completion: @escaping(ProfileDetails)->()){
//        print(userId,"profileeeeeee")
        guard let url = URL(string: "http://stagetao.gcf.education:3000/api/v1/profile/\(userId)") else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) {
              data,response,error in
              guard let data = data , error == nil else {
                print("Something went Wrong")
                return
              }
            if let httpResponse = response as? HTTPURLResponse ,
                 httpResponse.statusCode == 200 {
                  print("statusCode: \(httpResponse.statusCode)")
                do {
                   let result = try JSONDecoder().decode(ProfileModel.self,from: data)
                    DispatchQueue.main.async {
                        completion(result.data)
                    }
                }
                catch{
                  print("Error is because\(error.localizedDescription)")
                }
              }
        }
        task.resume()
    }
    
    func postPassword(userId: Int,model: Model , completion : @escaping(String) -> Void)
    {
        print(userId,"hiiiii")
        guard let url = URL(string: "http://stagetao.gcf.education:3000/api/v1/changePassword/\(userId)")else
        {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        do{
            let requestBody = try JSONEncoder().encode(model)
            request.httpBody = requestBody
            request.setValue("application/json", forHTTPHeaderField: "Content-type")
        }
        catch
        {
            print("Error")
        }
        let task = URLSession.shared.dataTask(with: request){ data ,response ,error in
        guard let data = data ,error == nil else{
            return
        }
        do{
            let responser = try JSONDecoder().decode(Response.self, from: data)
            print(responser)
            let jString = String(data: data,encoding:.utf8)!
//            print("success\(jString)")
            completion(jString)
        }
        catch{
            print("Error\(error.localizedDescription)")
        }
    }
    task.resume()
            
    }
    
//    --------jhansi
    func UpdatingByTextFields(requestObject: CreatePostModel,completion: @escaping (String) -> Void) {
        let url = URL(string: "http://stagetao.gcf.education:3000/api/v1/post")
        guard let url = url else {
          return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do{
          guard let result = try? JSONEncoder().encode(requestObject) else {
            return
          }
          request.httpBody = result
          request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        catch {
          print("It is Not encoded")
        }
        let task = URLSession.shared.dataTask(with: request) {
          data,response,error in
          guard let data = data , error == nil else {
            print("Something went Wrong")
            return
          }
          if let httpResponse = response as? HTTPURLResponse ,
             httpResponse.statusCode == 200 {
              print("statusCode: \(httpResponse.statusCode)")
            do {
              let responser = try JSONDecoder().decode(Welcome.self, from: data)
    //          let jsonString = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
//              print(responser.data?.userID)
//              print(responser.message)
              let jstring = String(data: data, encoding: . utf8)!

    //          print(jsonString)
              completion(jstring)
    //          print("Success:\(responser)")
            }
            catch{
              print("Error is because\(error.localizedDescription)")
            }
          }
        }
        task.resume()
      }
    
    func fetchData(userId : Int,postId : Int) {
        guard let url = URL(string: "http://stagetao.gcf.education:3000/api/v1/post/\(userId)") else {
          return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request, completionHandler: { data,response,error in
          guard let data = data , error == nil else {
            print("smthg went wrong")
            return
          }

        })
        task.resume()
      }
    
    
    
}
    
    

