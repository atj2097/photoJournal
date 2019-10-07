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
    func storeImage(images: [Image]) {
        UserDefaults.standard.set(images, forKey: imageKey)
    }
    
    func storeScrollDir(scorllDir: UICollectionView.ScrollDirection) {
        UserDefaults.standard.set(scorllDir, forKey: scrollDirKey)
    }
    func storeBackCol(backColor: UIColor) {
        UserDefaults.standard.set(backColor, forKey: backgroundColor)
    }
    
    
    //GET
    func getBackground() -> UIColor {
        return UserDefaults.standard.value(forKey: backgroundColor) as? UIColor ?? UIColor.red
    }
    func getScrollDir() -> UICollectionView.ScrollDirection? {
        return UserDefaults.standard.value(forKey: scrollDirKey) as? UICollectionView.ScrollDirection
    }
    func getImages() -> [Image?] {
        return [UserDefaults.standard.value(forKey: imageKey) as? Image]
    }
    
    
    
    
    // MARK: - Private inits and properties
    
    private init() {}
    
    private let scrollDirKey = "scroll"
    private let backgroundColor = "backgroundColor"
    private let imageKey = "imageKey"
}

