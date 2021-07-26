//
//  ResponseData.swift
//  Firstngo
//
//  Created by Artash Ghazaryan on 2/19/20.
//  Copyright © 2020 Artash Ghazaryan. All rights reserved.
//

import UIKit

class ResponseData {
    var isSuccess = false
    var data : [String:Any]?
    var errorForUser = ""
    var errorForDeveloper = ""
    
    init() {
        
    }
    
    init(data: Data?, response: URLResponse?, error: Error?) {
        
        do {
            if let dataResult = data {
                if let result = try JSONSerialization.jsonObject(with: dataResult,
                                                                 options: .mutableContainers) as? [String: Any] {
                    self.data = result
                    let status : String = self.data?["status"] as! String
                    if (status == "OK") {
                        isSuccess = true
                    }else if (status == "ORDER_EXISTS") {
                        isSuccess = true
                    }else {
                        isSuccess = false
                        errorForUser = self.data?["error"] as! String
                    }
                }
            }
        } catch let error {
            isSuccess = false
            print(error.localizedDescription)
        }
    }
    
    
    
    
}
