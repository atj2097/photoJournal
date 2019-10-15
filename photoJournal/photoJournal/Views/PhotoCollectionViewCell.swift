//
//  PhotoCollectionViewCell.swift
//  photoJournal
//
//  Created by God on 10/4/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
protocol PhotoCellDelegate: AnyObject {
    func actionSheet(tag: Int)
}

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var photoName: UILabel!
    
    @IBOutlet weak var photoDate: UILabel!
    
    @IBOutlet weak var buttonCell: UIButton!
    weak var delegate: PhotoCellDelegate?
    @IBAction func optionsClicked(_ sender: UIButton) {
        delegate?.actionSheet(tag: sender.tag)
    }

    
}

