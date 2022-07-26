
import Foundation
class Networker{
    let baseUrl = "http://stagetao.gcf.education:3000/"
    let networkWorkingLayer = putApi()
    func updateLikes(userId:Int, postId:Int ,status:Bool, completionHandler : @escaping (UpdateLikes) -> Void){
        guard let url = URL(string:"\(baseUrl)" + "\(urls.updateLikes.rawValue)\(postId)/\(userId)/\(status)") else{
            return
        }
        networkWorkingLayer.putMethodApiCalling(url: url) { data in
            
            var updateLikesResponse : UpdateLikes?
            do{
                updateLikesResponse = try JSONDecoder().decode(UpdateLikes.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }
            completionHandler(updateLikesResponse!)
        }
    }
    
    func logOutApiCall(userId:Int,completionHandler:@escaping(LogOutResponse)->Void){
        guard let url = URL(string:"\(baseUrl)" + "\(urls.logOut.rawValue)\(userId)") else{
            return
        }
        networkWorkingLayer.putMethodApiCalling(url: url) { data in
            var res : LogOutResponse?
            do{
                res = try JSONDecoder().decode(LogOutResponse.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }
            completionHandler(res!)
        }
    }
    
    
    func userRegisteration(model: RegisterDetails,completion : @escaping (String) -> Void){
        guard let url = URL(string: "\(baseUrl)\(urls.registerUrl.rawValue)")else
        {
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: model, completion: { data in
            do{
                let jsonString = try JSONSerialization.jsonObject(with: data)
                print("Success:\(jsonString)")
                let jString = String(data: data, encoding: .utf8)!
                completion(jString)
            }
            catch{
                print(error.localizedDescription)
            }
            
        })
    }
    
    
    func userLogin(model: LoginDetails,completion : @escaping (String) -> Void){
        guard let url = URL(string: "\(baseUrl)\(urls.loginUrl.rawValue)")else
        {
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: model) { data in
            do{
                let jsonString = try JSONSerialization.jsonObject(with: data)
                let jString = String(data: data, encoding: .utf8)!
                print("Success:\(jString)")
                completion(jString)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    func displayFriends(userId:Int,completionHandler:@escaping(DisplayFriendsResponse)->Void){
        print("display\(userId)")
        guard let url = URL(string:"\(baseUrl)\(urls.displayFriends.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url, completion: { data in
            var result : DisplayFriendsResponse?
            do{
                
                result = try JSONDecoder().decode(DisplayFriendsResponse.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }
            completionHandler(result!)
            
        })
    }
    
    func suggestedFriends(userId:Int,completionHandler:@escaping(SuggestedFriendsResponse)->Void){
        
        guard let url = URL(string: "\(baseUrl)\(urls.suggestFriends.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data in
            var result : SuggestedFriendsResponse?
            do{
                result = try JSONDecoder().decode(SuggestedFriendsResponse.self, from: data)
            }
            catch{
                print(error.localizedDescription)
            }
            completionHandler(result!)
        }
        
    }
    func getPosts(userId:Int,completionHandler:@escaping(GetPosts)->Void){
        guard let url = URL(string:"\(baseUrl)\(urls.getPosts.rawValue)\(userId)") else {
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data in
            var result : GetPosts?
            do{
                result = try? JSONDecoder().decode(GetPosts.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(result!)
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func addNewFriend(addFrdobj:AddNewFriend,completionHandler:@escaping(String)->Void){
        guard let url = URL(string: "\(baseUrl)\(urls.addNewFriend.rawValue)") else{
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: addFrdobj, completion: { data in
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
        })
    }
    
    func deleteFriend(frdId:Int,userId:Int ,completionHandler:@escaping(Any)->Void) {
        guard let url = URL(string:"\(baseUrl)\(urls.deleteFriend.rawValue)\(frdId)/\(userId)") else {
            return
        }
        
        networkWorkingLayer.delMethodApiCalling(url: url) { data in
            
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
                completionHandler(jsonObj)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func fetchingProfileData(userId: Int,completion: @escaping(ProfileDetails)->()){
        
        guard let url = URL(string: "\(baseUrl)\(urls.displayUserProfile.rawValue)\(userId)") else{
            return
        }
        networkWorkingLayer.getMethodApiCalling(url: url) { data in
            do {
                let result = try JSONDecoder().decode(ProfileModel.self,from: data)
                DispatchQueue.main.async {
                    completion(result.data)
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func passwordChange(userId: Int,model: PasswordDetails, completion : @escaping(String) -> Void)
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
                //        throw URLError(.badServerResponse)
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
    
    
    func createPost(requestObject: CreatePostModel,completion: @escaping (String) -> Void) {
        let url = URL(string: "\(baseUrl)\(urls.createPost.rawValue)")
        guard let url = url else {
            return
        }
        networkWorkingLayer.postMethodApicalling(url: url, encode: requestObject) { data in
            
            do {
                let jsonString = try JSONSerialization.jsonObject(with: data,options: .fragmentsAllowed)
                let jstring = String(data: data, encoding: . utf8)!
                completion(jstring)
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func delPost(userId : Int,postId : Int,completion : @escaping(DelPost) -> Void) {
        guard let url = URL(string: "\(baseUrl)\(urls.deletePost.rawValue)\(userId)/\(postId)") else {
            return
        }
        print(url)
        networkWorkingLayer.delMethodApiCalling(url: url) { data in
            do{
                let jsonString = try JSONSerialization.jsonObject(with: data)
                let deleteResponse = try JSONDecoder().decode(DelPost.self, from: data)
                completion(deleteResponse)
            }
            catch {
                print("delete error is because\(error.localizedDescription)")
            }
        }
        
    }
}
