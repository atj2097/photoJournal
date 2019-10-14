//
//  PhotoViewController.swift
//  photoJournal
//
//  Created by God on 10/4/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
private let reuseIdentifier = "photoCell"
class PhotoViewController: UIViewController {
    var photoCollection = [Image]() {
        didSet {
            //getImagesFor()
            photoCollectionView.reloadData()
        }
    }

    let layOut: UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadDefaultSettings()
        getImagesFor()
    }
    private func loadDefaultSettings() {
        //black color
        if UserDefaultsWrapper.manager.getBackground() == true {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            photoCollectionView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        else {
            self.view.backgroundColor = #colorLiteral(red: 0.5515964627, green: 0.7481098175, blue: 0.9596171975, alpha: 1)
            photoCollectionView.backgroundColor = #colorLiteral(red: 0.5515964627, green: 0.7481098175, blue: 0.9596171975, alpha: 1)
        }
        
        //scrollDirection
        layOut.itemSize = CGSize(width: 250, height: 250)
        if UserDefaultsWrapper.manager.getScrollDir() == true {
            layOut.scrollDirection = .horizontal
            photoCollectionView.setCollectionViewLayout(layOut, animated: true)
        }
            
        else {
            layOut.scrollDirection = .vertical
            photoCollectionView.setCollectionViewLayout(layOut, animated: true)
        }
        
    }
    
    private func getImagesFor() {
        do {
            photoCollection = try ImagePersistenceManager.manager.getImages()
        }
        catch {
            print(error)
        }
        
    }
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBAction func addPhoto(_ sender: UIBarButtonItem) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addPhoto") as! EditingViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getImagesFor()
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
    }
  
    
    
    
}
extension PhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCollectionViewCell
        let photo = photoCollection[indexPath.row]
        cell.photoName.text = photo.name
        cell.photoDate.text = photo.postedDate
        cell.photoView.image = UIImage(data: photo.imageData)
        cell.buttonCell.tag = indexPath.row
        cell.delegate = self
        
        // Configure the cell
        
        return cell
    }
    
}
extension PhotoViewController: PhotoCellDelegate {
    func actionSheet(tag: Int) {
        let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        optionMenu.addAction(cancelAction)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { (action) in
            //            let image = self.photoCollection[tag]
            
            self.photoCollection.remove(at: tag)
            
        }
        optionMenu.addAction(deleteAction)
        let editAction = UIAlertAction(title: "Edit", style: .destructive) { (action) in
            let image = self.photoCollection[tag]
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "addPhoto") as! EditingViewController
            nextViewController.imageNew = image
            self.present(nextViewController, animated:true, completion:nil)
        }
        optionMenu.addAction(editAction)
        
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
}
