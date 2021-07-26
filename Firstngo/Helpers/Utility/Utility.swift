//
//  Utility.swift
//  HyperScript
//
//  Created by art on 9/2/19.
//  Copyright © 2019 Hyper Script. All rights reserved.
//

import Foundation

import UIKit

let defaults = UserDefaults.standard


final class Utility: NSObject {

    class func saveUserToken( token: String ) {
        saveOnDefaults(value: token, key: Constants.UserDataKeys.token)
    }
    
    class func getUser() -> UserInfo {
        let token: String = getStringFromDefaults(key: Constants.UserDataKeys.token)
        let userInfo = UserInfo(token: token)
        return userInfo
    }
    
    fileprivate class func saveOnDefaults(value: String, key: String) {
        defaults.set(value, forKey: key)
    }
    
    fileprivate class func saveOnDefaults(value: [String: String], key: String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    fileprivate class func saveOnDefaults(value: [String: Any], key: String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    fileprivate class func saveOnDefaults(value: Bool, key: String) {
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    fileprivate class func removeFromDefaults(key: String) {
        defaults.removeObject(forKey:key)
        defaults.synchronize()
    }
    
    fileprivate class func getFromDefaults(key: String) -> Any {
        guard let value = defaults.value(forKey: key) as? String else {
            return ""
        }
        return value
    }
    
    fileprivate class func getStringFromDefaults(key: String) -> String {
        guard let value = defaults.value(forKey: key) as? String else {
            return ""
        }
        return value
    }
    
    fileprivate class func getBoolFromDefaults(key: String) -> Bool {
        guard let value = defaults.value(forKey: key) as? Bool else {
            return false
        }
        return value
    }
    
    fileprivate class func getDictFromDefaults(key: String) -> Any {
        guard let value = defaults.value(forKey: key) as? [String:String] else {
            return []
        }
        return value
    }
    
    class func removeAllFromDefaults() {
        defaults.removeObject(forKey: Constants.UserDataKeys.token)
        defaults.synchronize()
    }
    
}
