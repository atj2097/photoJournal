//
//  EditingViewController.swift
//  photoJournal
//
//  Created by God on 10/4/19.
//  Copyright © 2019 God. All rights reserved.
//

import UIKit
import AssetsLibrary
import Photos
var photoName = String()

class EditingViewController: UIViewController {
    var imageNew: Image!
    
    @IBOutlet weak var imageUpload: UIImageView!
    @IBOutlet weak var showLibrary: UIBarButtonItem!
    
    //Actions
    @IBAction func showPhotos(_ sender: Any) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        present(imagePickerVC, animated: true)
    }
    
    @IBAction func saveImage(_ sender: Any) {
        let formatter = DateFormatter()
        //2016-12-08 03:37:22 +0000
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        let now = Date()
        let dateString = formatter.string(from:now)
        NSLog("%@", dateString)
        guard let imageData = self.imageUpload.image?.jpegData(compressionQuality: 0.5) else {return}
        let imageInfo = Image(postedDate: dateString, name: textView.text , imageData: imageData, id: 0)
        try? ImagePersistenceManager.manager.saveImage(image: imageInfo)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        loadDefaultSettings()
        setUpViews()
    }
    
    func setUpViews() {
        textView.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // Do any additional setup after loading the view.
        textView.becomeFirstResponder()
        textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
        navigationController?.navigationBar.isHidden = true
        if self.imageUpload.image != UIImage(named: "_upload_image-512") {
            imageUpload.image = UIImage(data: imageNew.imageData!)
        }
    }
    //MARK: Private Func
    private func loadDefaultSettings() {
        if UserDefaultsWrapper.manager.getBackground() == true {
            self.view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        else {
            self.view.backgroundColor = #colorLiteral(red: 0.5515964627, green: 0.7481098175, blue: 0.9596171975, alpha: 1)
        }
        //UISwitchColor
    }
    
    
}
//extension EditingViewController: UITextViewDelegate  {
//
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//        textView.text = ""
//    }
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            textView.text = "Placeholder"
//            textView.textColor = UIColor.lightGray
//        }
//    }
//    func textViewDidChangeSelection(_ textView: UITextView) {
//        if self.view.window != nil {
//            if textView.textColor == UIColor.lightGray {
//                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//            }
//            else {
//                textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//            }
//        }
//    }
//    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
//
//        // Combine the textView text and the replacement text to
//        // create the updated text string
//        let currentText:String = textView.text
//        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
//
//        // If updated text view will be empty, add the placeholder
//        // and set the cursor to the beginning of the text view
//        if updatedText.isEmpty {
//
//            textView.text = "Placeholder"
//            textView.textColor = UIColor.lightGray
//
//            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument, to: textView.beginningOfDocument)
//        }
//
//            // Else if the text view's placeholder is showing and the
//            // length of the replacement string is greater than 0, set
//            // the text color to black then set its text to the
//            // replacement string
//        else if textView.textColor == UIColor.lightGray && !text.isEmpty {
//            textView.textColor = UIColor.black
//            textView.text = text
//        }
//
//            // For every other case, the text should change with the usual
//            // behavior...
//        else {
//            return true
//        }
//
//        // ...otherwise return false since the updates have already
//        // been made
//        return false
//    }
//
//    private func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        textField.placeholder = ""
//        return true
//    }
//}

extension EditingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        if let asset = info[UIImagePickerController.InfoKey.phAsset] as? PHAsset{
            if let fileName = asset.value(forKey: "filename") as? String{
                photoName = fileName
            }
        }
        imageUpload.image = image
        dismiss(animated: true, completion: nil)
        
    }
}

