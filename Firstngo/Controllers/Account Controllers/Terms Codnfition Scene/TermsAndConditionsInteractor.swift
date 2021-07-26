//
//  TermsAndConditionsInteractor.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/16/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol TermsAndConditionsBusinessLogic
{
  func doSomething(request: TermsAndConditions.Something.Request)
}

protocol TermsAndConditionsDataStore
{
  //var name: String { get set }
}

class TermsAndConditionsInteractor: TermsAndConditionsBusinessLogic, TermsAndConditionsDataStore
{
  var presenter: TermsAndConditionsPresentationLogic?
  var worker: TermsAndConditionsWorker?
  //var name: String = ""
  
  // MARK: Do something
  
  func doSomething(request: TermsAndConditions.Something.Request)
  {
    worker = TermsAndConditionsWorker()
    worker?.doSomeWork()
    
    let response = TermsAndConditions.Something.Response()
    presenter?.presentSomething(response: response)
  }
}
