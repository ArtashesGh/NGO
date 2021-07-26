//
//  NetworkManager.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/19/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class NetworkManager {
    
    static func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
    
    //MARK: - Authorization
    
    static func requestLogin(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let originalString = SERVER_URL + API_LOGIN
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString ?? "")!
        RequestData.requestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestRegister(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_REGISTER)!
        RequestData.requestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    //MARK: - Forgot Password
    
    static func requestSendCode(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_SEND_CODE + "?" + getPostString(params: userInfo))!
        RequestData.requestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestCheckCode(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_CHECK_CODE + "?" + getPostString(params: userInfo))!
        RequestData.requestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestNewPass(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_NEW_PASS + "?" + getPostString(params: userInfo))!
        RequestData.requestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    //MARK: - get/save User
    
    static func requestGetUser(completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_USER)!
        RequestData.getRequestServer(url: url, userInfo: ["a":"a"], completion: completion)
    }
    
    static func requestSaveUser(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let originalString = SERVER_URL + API_SAVE_USER + "?" + getPostString(params: userInfo)
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString ?? "")!
        RequestData.requestServerAuthorization(url: url, userInfo: userInfo, completion: completion)
    }
    
    //MARK: - Region
    
    static func requestGetCountry(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let originalString = SERVER_URL + API_COUNTRY + "?" + getPostString(params: userInfo)
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString ?? "")!
        RequestData.getRequestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestGetCity(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let originalString = SERVER_URL + API_CITY + "?" + getPostString(params: userInfo)
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString ?? "")!
        RequestData.getRequestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    //MARK: - Services
    static func requestGetUserServices(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_USER_SERVICES + "?" + getPostString(params: userInfo))!
        RequestData.getRequestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestGetServices(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_ALL_SERVICES + "?" + getPostString(params: userInfo))!
        RequestData.getRequestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestGetOneOrder(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_GET_ONE + "?" + getPostString(params: userInfo))!
        RequestData.getRequestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestGetUserOrder(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_ORDER_ONE + "?" + getPostString(params: userInfo))!
        RequestData.getRequestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestCreateOrder(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_ORDER_CREATE)!
        RequestData.requestServerAuthorization(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestPayment(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
       {
           let url = URL(string: SERVER_URL + API_ORDER_PAYMENT)!
           RequestData.requestServerAuthorization(url: url, userInfo: userInfo, completion: completion)
       }
    
    
    //MARK: - Chat
    
    static func requestGetChat(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_GET_CHAT + "?" + getPostString(params: userInfo))!
        RequestData.getRequestServer(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestSendChat(userInfo: [String:Any], completion: (( _ response: ResponseData) -> Void)?)
    {
        let originalString = SERVER_URL + API_SEND_CHAT + "?" + getPostString(params: userInfo)
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString ?? "")!
        RequestData.requestServerAuthorization(url: url, userInfo: userInfo, completion: completion)
    }
    
    static func requestUploadImnage(image: UIImage, completion: (( _ response: ResponseData) -> Void)?)
    {
        let url = URL(string: SERVER_URL + API_UPLOAD_FILE)!
        RequestData.requestServerUploadImage(url: url, image: image, completion: completion)
    }
}
