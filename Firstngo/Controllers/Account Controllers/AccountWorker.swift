//
//  AccountWorker.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/24/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

class AccountWorker
{
    func doGetProfileWork(completion: (( _ response: ResponseData) -> Void)? ) {
        NetworkManager.requestGetUser( completion: completion)
    }
    
    func doSaveProfileWork(name:String,
                           city:UInt64,
                           phoneNumber:String,
                           country:UInt64,
                           isUserAgreementAccepted:Bool,
                           completion: (( _ response: ResponseData) -> Void)? ) {
        NetworkManager.requestSaveUser(userInfo: ["name" : name,
                                                      "phoneNumber" : phoneNumber,
                                                      "city" : city,
                                                      "country" : country,
                                                      "isUserAgreementAccepted" : isUserAgreementAccepted], completion: completion)
    }
}