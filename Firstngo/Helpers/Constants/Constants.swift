//
//  Constants.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/19/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit
import Foundation

struct Constants {
    
    struct Roboto {
           public static let regular = "Roboto-Regular"
           public static let light = "Roboto-Light"
           public static let bold = "Roboto-Bold"
           public static let medium = "Roboto-Medium"
       }
    
    struct Colors {
        public static let textFieldBorderColor = UIColor(white: 235.0/255.0, alpha: 1.0)
        public static let textFieldErrorBorderColor = UIColor(red: 236.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
        public static let textFieldPlaceholderColor = UIColor(red: 161.0/255.0, green: 161.0/255.0, blue: 166.0/255.0, alpha: 1.0)
        
        public static let borderGreyColor = UIColor(red: 208.0/255.0, green: 210.0/255.0, blue: 222.0/255.0, alpha: 1.0)
        
        public static let orderGreenColor = UIColor(red: 122.0/255.0, green: 199.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        public static let orderSirenColor = UIColor(red: 89.0/255.0, green: 60.0/255.0, blue: 125.0/255.0, alpha: 1.0)
        public static let orderGreyColor = UIColor(red: 173.0/255.0, green: 173.0/255.0, blue: 173.0/255.0, alpha: 1.0)
        public static let orderRedColor = UIColor(red: 242.0/255.0, green: 46.0/255.0, blue: 33.0/255.0, alpha: 1.0)
        public static let orderBlueColor = UIColor(red: 58.0/255.0, green: 124.0/255.0, blue: 236.0/255.0, alpha: 1.0)
        
        public static let grey = UIColor(red: 169.0/255.0, green: 176.0/255.0, blue: 189.0/255.0, alpha: 1.0)
        public static let bleuStart = UIColor(red: 32.0/255.0, green: 115.0/255.0, blue: 199.0/255.0, alpha: 1.0)
         public static let bleuEnd = UIColor(red: 82.0/255.0, green: 218.0/255.0, blue: 227.0/255.0, alpha: 1.0)
    }
    
    struct Storyboards {
        public static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        public static let authenticationStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        public static let alertStoryboard = UIStoryboard(name: "Alert", bundle: nil)
        public static let accountStoryboard = UIStoryboard(name: "Account", bundle: nil)
        public static let servicesStoryboard = UIStoryboard(name: "Services", bundle: nil)
    }
    
    struct UserDataKeys {
        
        public static let token = "token"
       
    }
    
}

struct UserInfo: Codable {
       var token: String
   }
