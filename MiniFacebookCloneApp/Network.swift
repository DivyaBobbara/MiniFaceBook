//
//  Network.swift
//  MiniFacebookCloneApp
//
//  Created by Sandhya Kollati on 21/07/22.
//

import Foundation
import Foundation
class Networker{
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
           print("here")
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
}
