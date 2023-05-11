//
//  UserDefaultsWrapper.swift
//  GestureLogin
//
//  Created by chijung chan  on 2023/5/10.
//

import Foundation
@propertyWrapper
struct UserDefaultsWrapper <T> {
    
    enum DefaultKey: String {
        // Bool
        case isOpen
        
        // String
//        case accessToken

        //Int
//        case count
        
    }
    
    private var key: DefaultKey
    
    init(key: DefaultKey)
    {
        self.key = key
    }
    
    var wrappedValue: T?
    {
        get
        {
            switch T.self {
            case is String.Type:
                return UserDefaults.standard.string(forKey: key.rawValue) as? T
                
            case is Bool.Type:
                return UserDefaults.standard.bool(forKey: key.rawValue) as? T
            
            case is Int.Type:
                return UserDefaults.standard.integer(forKey: key.rawValue) as? T
                
            default:
                return nil
            }
        }
        set
        {
            switch T.self {
            case is String.Type:
                guard let value = newValue as? String else { return }
                UserDefaults.standard.set(value, forKey: key.rawValue)
                
            case is Bool.Type:
                guard let value = newValue as? Bool else { return }
                UserDefaults.standard.set(value, forKey: key.rawValue)
            
            case is Int.Type:
                guard let value = newValue as? Int else { return }
                UserDefaults.standard.set(value, forKey: key.rawValue)
                
            default:
                break
            }
        }
    }
}
