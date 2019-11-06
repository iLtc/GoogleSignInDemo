//
//  ConfigService.swift
//  GoogleSignInDemo
//
//  Created by Alan Luo on 11/6/19.
//  Copyright © 2019 iLtc. All rights reserved.
//

import UIKit

class ConfigService: NSObject {
    static var instance = ConfigService()
    
    private var configs: NSDictionary
    
    init(_ name: String){
        super.init()
        
        let configPath = Bundle.main.url(forResource: name, withExtension: "plist")
        configs = NSDictionary(contentsOf: configPath!)!
    }
    
    func get(_ key: String) -> String? {
        if let value = configs[key] {
            return (value as! String)
        } else {
            return nil
        }
    }
}
