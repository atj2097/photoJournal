//
//  UserModel.swift
//  photoJournal
//
//  Created by God on 10/4/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation
import UIKit
class UserDefaultsWrapper {
    
    // MARK: - Static Properties
    
    static let manager = UserDefaultsWrapper()
    
    // MARK: - Internal Methods
    //STORE
 
    func storeScrollDir(scorllDir: Bool) {
        UserDefaults.standard.set(scorllDir, forKey: scrollDirKey)
    }
    func storeBackCol(backColor: Bool) {
        UserDefaults.standard.set(backColor, forKey: backgroundColor)
    }
    
    
    //GET
    func getBackground() -> Bool? {
        return UserDefaults.standard.value(forKey: backgroundColor) as? Bool ?? true
    }
    func getScrollDir() -> Bool? {
        return (UserDefaults.standard.value(forKey: scrollDirKey) as? Bool) ?? true
    }

    
    
    
    // MARK: - Private inits and properties
    
    private init() {}
    
    private let scrollDirKey = "scroll"
    private let backgroundColor = "backgroundColor"
}

