//
//  NewPasswordPresenter.swift
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

protocol NewPasswordPresentationLogic
{
    func presentSomething(email:String, code:String)
    func presentSuccess()
    func presentError(error: String)
    func showLoader()
    func hideLoader()
}

class NewPasswordPresenter: NewPasswordPresentationLogic
{
    weak var viewController: NewPasswordDisplayLogic?
    
    // MARK: Do something
    
    func presentSomething(email:String, code:String)
    {
        
        viewController?.displaySomething(email:email, code:code)
    }
    
    func presentSuccess() {
        viewController?.displaySuccess()
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
