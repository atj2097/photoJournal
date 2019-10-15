//
//  photoJournalTests.swift
//  photoJournalTests
//
//  Created by God on 10/4/19.
//  Copyright © 2019 God. All rights reserved.
//

import XCTest
import UIKit
@testable import photoJournal

class photoJournalTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testImagePersistenceIsWorking() {
        //This function is to check to see if I am properly saving my Image
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let now = Date()
        let dateString = formatter.string(from:now)
        NSLog("%@", dateString)
        
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "Avengers-Endgame-Rerelease-New-Footage")
        let textView = UITextView()
        
        guard let imageData = imageView.image?.jpegData(compressionQuality: 0.5) else {return}
        
        let imageInfo = Image(postedDate: dateString, name: textView.text , imageData: imageData)
        do {
            try ImagePersistenceManager.manager.saveImage(image: imageInfo)
    }
        catch {
            print("Not Saving Image")
        }
    }
    
    func testGettingImages() {
        var photoCollection = [Image]()
        func getImagesFor() {
            do {
                photoCollection = try ImagePersistenceManager.manager.getImages()
            }
            catch {
                print(error)
            }
            
        }
            
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            
            // Put the code you want to measure the time of here.
        }
    }

}
