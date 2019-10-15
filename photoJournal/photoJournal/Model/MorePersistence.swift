//
//  MorePersistence.swift
//  photoJournal
//
//  Created by God on 10/7/19.
//  Copyright © 2019 God. All rights reserved.
//

import Foundation
struct ImagePersistenceManager {
    private init() {}
    static let manager = ImagePersistenceManager()


    private let persistenceHelper = PersistenceHelper<Image>(fileName: "image.plist")


    func saveImage(image: Image) throws {
        try persistenceHelper.save(newElement: image)

    }

    func getImages() throws -> [Image] {
        return try persistenceHelper.getObjects()
    }
    
    func deletePhoto(specificID: Int) throws {
        do {
            let images = try getImages()
            let newImages = images.filter { $0.id != specificID}
            try persistenceHelper.replace(elements: newImages)
        }
    }




}
