//
//  Settings.swift
//  GestureLogin
//
//  Created by chijung chan  on 2023/5/10.
//

import Foundation
struct Settings {
    
    @UserDefaultsWrapper(key: .count) static var count: Int?
    
    
}
