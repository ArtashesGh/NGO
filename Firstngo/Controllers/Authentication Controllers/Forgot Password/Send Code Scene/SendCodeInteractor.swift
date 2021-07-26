//
//  SendCodeInteractor.swift
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

protocol SendCodeBusinessLogic
{
    func doSomething()
    func doNewPassword(request: SendCode.Something.Request)
    func doReSned(request: SendCode.Something.Request)
    
}

protocol SendCodeDataStore
{
    var email: String { get set }
    var code: String { get set }
}

class SendCodeInteractor: SendCodeBusinessLogic, SendCodeDataStore
{
    var presenter: SendCodePresentationLogic?
    var worker: SendCodeWorker?
    var workerReq: RequestCodeWorker?
    var email: String = ""
    var code: String = ""
    
    // MARK: Do something
    
    func doSomething()
    {
        
        presenter?.presentSomething(email: email)
    }
    
    func doNewPassword(request: SendCode.Something.Request) {
        worker = SendCodeWorker()
        presenter?.showLoader()
        _ = worker?.doCheckCodeWorker(email: request.email,
                                      code: request.code,
                                      completion: { response in
                                        if (response.isSuccess) {
                                            self.presenter?.hideLoader()
                                            self.presenter?.presentCheckCodeSuccess()
                                        }else {
                                            self.presenter?.hideLoader()
                                            self.presenter?.presentError(error: response.errorForUser)
                                        }
        })
    }
    
    func doReSned(request: SendCode.Something.Request) {
        workerReq = RequestCodeWorker()
        presenter?.showLoader()
        _ = workerReq?.doRequestCodeWorker(email: request.email,
                                           completion: { response in
                                            if (response.isSuccess) {
                                                self.presenter?.hideLoader()
                                                self.presenter?.presentReSendSuccess()
                                            }else {
                                                self.presenter?.hideLoader()
                                                self.presenter?.presentError(error: response.errorForUser)
                                            }
        })
    }
}
