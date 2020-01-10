//
//  UserDefaultsStorage.swift
//  PokeMaster
//
//  Created by 张艺哲 on 2020/1/9.
//  Copyright © 2020 OneV's Den. All rights reserved.
//

import Foundation
import Combine

@propertyWrapper
struct UserDefaultsStorage<Bool:Codable> {
    var value: Bool
    
    let key: String
    
    init(key: String) {
        if let currentValue = UserDefaults.standard.value(forKey: key) as? Bool {
            value = currentValue
        } else {
            value = false as! Bool
        }
        self.key = key
    }
    
    var wrappedValue: Bool {
        set {
            value = newValue
            UserDefaults.standard.set(value, forKey: key)
        }
        
        get {value}
    }
}
