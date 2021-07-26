//
//  SendCodePresenter.swift
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

protocol SendCodePresentationLogic
{
    func presentSomething(email: String)
    func presentReSendSuccess()
    func presentCheckCodeSuccess()
    func presentError(error: String)
    func showLoader()
    func hideLoader()
}

class SendCodePresenter: SendCodePresentationLogic
{
    weak var viewController: SendCodeDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(email:String)
    {
        viewController?.displaySomething(email: email)
    }
    
    func presentReSendSuccess() {
        viewController?.displayReSendSuccess()
    }
    func presentCheckCodeSuccess() {
        viewController?.displayCheckSuccess()
    }
    
    func presentError(error: String) {
        viewController?.displayError()
    }
    
    func showLoader() {
        viewController?.showLoader()
    }
    func hideLoader() {
        viewController?.hideLoader()
    }
}