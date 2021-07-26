//
//  ChatInteractor.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/10/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ChatBusinessLogic {
    func doSomething(request: Chat.Something.Request)
    func doSendMessage(message: String)
    func doGetProfile()
}

protocol ChatDataStore
{
    //var name: String { get set }
}

class ChatInteractor: ChatBusinessLogic, ChatDataStore
{
    var presenter: ChatPresentationLogic?
    var worker: ChatWorker?
    var workerAcoount: AccountWorker?
    //var name: String = ""
    
    // MARK: Do something
    
    func doSomething(request: Chat.Something.Request)
    {
        worker = ChatWorker()
        
        _ = worker?.doGetChat(page: request.page,
                              completion:  { response in
                                if (response.isSuccess) {
                                    self.presenter?.hideLoader()
                                    if let chatInfo: [[String:Any]] = response.data?["object"] as? [[String:Any]] {
                                        var chatList:[ChatInfo] = []
                                        
                                        do{
                                            for chatItem in chatInfo {
                                                let jsonData = try? JSONSerialization.data(withJSONObject:chatItem)
                                                let chatInfoItem = try  JSONDecoder().decode(ChatInfo.self,from: jsonData!)
                                                chatList.append(chatInfoItem)
                                            }
                                            self.presenter?.presentGetChatSuccess(chatList:chatList)
                                        }catch let jsonErr {
                                            print(jsonErr)
                                        }
                                    }
                                    
                                } else {
                                    self.presenter?.hideLoader()
                                    self.presenter?.presentError(error: response.errorForUser)
                                }
                                
        })
    }
    
    func doSendMessage(message: String)
    {
        worker = ChatWorker()
        presenter?.showLoader()
        _ = worker?.doSendChat(message: message,
                              completion:  { response in
                                if (response.isSuccess) {
                                    self.presenter?.hideLoader()
                                    let newMessage: [String:Any] = response.data?["object"] as! [String:Any]
                                    do{
                                            let jsonData = try? JSONSerialization.data(withJSONObject:newMessage)
                                            let chatInfoItem = try  JSONDecoder().decode(ChatInfo.self,from: jsonData!)
                                        self.presenter?.presentSendChatSuccess(chatItem: chatInfoItem)
                                    }catch let jsonErr {
                                        print(jsonErr)
                                    }
                                    
                                } else {
                                    self.presenter?.hideLoader()
                                    self.presenter?.presentError(error: response.errorForUser)
                                }
                                
        })
    }
    
    func doGetProfile() {
        
        workerAcoount = AccountWorker()
        _ = workerAcoount?.doGetProfileWork(completion: { response in
            if (response.isSuccess) {
                self.presenter?.hideLoader()
                let userInfo: [String:Any] = response.data?["object"] as! [String:Any]
                do{
                    let jsonData = try? JSONSerialization.data(withJSONObject:userInfo)
                    let user = try  JSONDecoder().decode(User.self,from: jsonData!)
                    self.presenter?.presentGetProfileSuccess(userInfo: user)
                }catch let jsonErr {
                    print(jsonErr)
                }
            } else {
                self.presenter?.hideLoader()
                self.presenter?.presentError(error: response.errorForUser)
            }
        })
    }
}

struct ChatInfo: Codable {
    var id : Int
    var content : String?
    var dateCreate : String?
    var userId : Int?
}
