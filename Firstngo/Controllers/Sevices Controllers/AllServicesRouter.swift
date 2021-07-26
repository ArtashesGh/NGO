//
//  AllServicesRouter.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 3/6/20.
//  Copyright (c) 2020 Artash Ghazaryan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol AllServicesRoutingLogic
{
    func routeToOrderViewController()
    func routeToChat()
}

protocol AllServicesDataPassing
{
    var dataStore: AllServicesDataStore? { get set }
}

class AllServicesRouter: NSObject, AllServicesRoutingLogic, AllServicesDataPassing
{
    weak var viewController: AllServicesViewController?
    var dataStore: AllServicesDataStore?
    
    // MARK: Routing
    
    func routeToOrderViewController()
    {
        let destinationVC = Constants.Storyboards.servicesStoryboard.instantiateViewController(withIdentifier: "OrderViewController") as! OrderViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToOrderViewController(source: dataStore!, destination: &destinationDS)
        navigateToOrderViewController(source: viewController!, destination: destinationVC)
    }
    
    func routeToChat() {
        let destinationVC = Constants.Storyboards.servicesStoryboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        
        navigateToChat(source: viewController!, destination: destinationVC)
    }
    
    
    // MARK: Navigation
    
    func navigateToOrderViewController(source: AllServicesViewController, destination: OrderViewController)
    {
        source.show(destination, sender: nil)
    }
    
    func navigateToChat(source: AllServicesViewController, destination: ChatViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToOrderViewController(source: AllServicesDataStore, destination: inout OrderDataStore)
    {
        destination.isUserOrder = false
        destination.orderId = source.orderId
    }
}
