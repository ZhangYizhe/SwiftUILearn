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
struct UserDefaultsStorage<T:Codable> {
    var value: T?
    enum keyType {
        case bool
    }
    
    let key: String
    let type: keyType
    
    init(key: String, type: keyType) {
        if let currentValue = UserDefaults.standard.value(forKey: key) as? T {
            value = currentValue
        } else {
            value = nil
        }
        self.key = key
    }
    
    var wrappedValue: T? {
        set {
            value = newValue
            UserDefaults.standard.set(value, forKey: key)
        }
        
        get {value}
    }
}
