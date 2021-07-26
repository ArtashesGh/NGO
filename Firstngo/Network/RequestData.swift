//
//  RequestData.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/19/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class RequestData {
    
    static func createPostRequest(url: URL, params: [String:Any]) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params,
                                                          options: .prettyPrinted)
            
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
        return request
    }
    
    static func requestServer(url: URL,
                              userInfo: [String:Any],
                              completion: (( _ response: ResponseData) -> Void)?)
    {
        let session = URLSession.shared
        if let request = RequestData.createPostRequest(url: url, params: userInfo) {
            let task = session.dataTask(with: request as URLRequest,
                                        completionHandler:
                { data, response, error in
                    let response = ResponseData(data: data, response: response, error: error)
                    completion?(response)
            })
            task.resume()
        } else {
            let response = ResponseData()
            completion?(response)
        }
    }
    
    static func createPostAuthorizationRequest(url: URL, params: [String:Any]) -> URLRequest? {
        var request = URLRequest(url: url)
         let basicToken:String = "Basic-" + Utility.getUser().token
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(basicToken, forHTTPHeaderField: "Authorization")
        do {
                   request.httpBody = try JSONSerialization.data(withJSONObject: params,
                                                                 options: [])
                   
               } catch let error {
                   print(error.localizedDescription)
                   return nil
               }
               return request
    }
    
    static func requestServerUploadImage(url: URL,
                              image: UIImage,
                              completion: (( _ response: ResponseData) -> Void)?)
    {
        let session = URLSession.shared
        if let request = RequestData.createPostRequestUploadImage( paramName: "file", fileName: "Document", image: image, url: url) {
            let task = session.dataTask(with: request as URLRequest,
                                        completionHandler:
                { data, response, error in
                    let response = ResponseData(data: data, response: response, error: error)
                    completion?(response)
            })
            task.resume()
        } else {
            let response = ResponseData()
            completion?(response)
        }
    }
    
    static func createPostRequestUploadImage(paramName: String, fileName: String, image: UIImage, url: URL) -> URLRequest? {

        // generate boundary string using a unique per-app string
        let boundary = UUID().uuidString
        let basicToken:String = "Basic-" + Utility.getUser().token
        var request = URLRequest(url: url)

        // Set the URLRequest to POST and to the specified URL
        request.httpMethod = "POST"
         request.addValue(basicToken, forHTTPHeaderField: "Authorization")
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var data = Data()

        // Add the image data to the raw http request data
        data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
        data.append(image.pngData()!)

        data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        request.httpBody = data
        return request
    }
    
    
    static func requestServerAuthorization(url: URL,
                              userInfo: [String:Any],
                              completion: (( _ response: ResponseData) -> Void)?)
    {
        let session = URLSession.shared
        if let request = RequestData.createPostAuthorizationRequest(url: url, params: userInfo) {
            let task = session.dataTask(with: request as URLRequest,
                                        completionHandler:
                { data, response, error in
                    let response = ResponseData(data: data, response: response, error: error)
                    completion?(response)
            })
            task.resume()
        } else {
            let response = ResponseData()
            completion?(response)
        }
    }
    
    
    static func createGetRequest(url: URL, params: [String:Any]) -> URLRequest? {
        let basicToken:String = "Basic-" + Utility.getUser().token
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(basicToken, forHTTPHeaderField: "Authorization")
        
//       do {
//           request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
//        } catch let error {
//           print(error.localizedDescription)
//            return nil
//        }
        return request
    }
    
    static func getRequestServer(url: URL,
                              userInfo: [String:Any],
                              completion: (( _ response: ResponseData) -> Void)?)
    {
        let session = URLSession.shared
        if let request = RequestData.createGetRequest(url: url, params: userInfo) {
            let task = session.dataTask(with: request as URLRequest,
                                        completionHandler:
                { data, response, error in
                    let response = ResponseData(data: data, response: response, error: error)
                    completion?(response)
            })
            task.resume()
        } else {
            let response = ResponseData()
            completion?(response)
        }
    }
}
