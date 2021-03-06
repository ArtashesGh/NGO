//
//  SIgnInRouter.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/21/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol SIgnInRoutingLogic
{
    func routeToForgotScreen()
    func routeToHomeTab()
}

protocol SIgnInDataPassing
{
    var dataStore: SIgnInDataStore? { get }
}

class SIgnInRouter: NSObject, SIgnInRoutingLogic, SIgnInDataPassing
{
    weak var viewController: SIgnInViewController?
    var dataStore: SIgnInDataStore?
    
    // MARK: Routing
    
    func routeToForgotScreen() {
        let destinationVC = Constants.Storyboards.authenticationStoryboard.instantiateViewController(withIdentifier: "RequestCodeViewController") as! RequestCodeViewController
        navigateToForgotScreen(source: viewController!, destination: destinationVC)
    }
    
    func routeToHomeTab() {
        let destinationVC = Constants.Storyboards.mainStoryboard.instantiateViewController(withIdentifier: "HomeTabBarViewController") as! HomeTabBarViewController
        navigateToMainTab(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToForgotScreen(source: SIgnInViewController, destination: RequestCodeViewController)
    {
        source.show(destination, sender: nil)
    }
    
    func navigateToMainTab(source: SIgnInViewController, destination: HomeTabBarViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: SIgnInDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
