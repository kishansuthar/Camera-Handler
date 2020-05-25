//
//  ViewController.swift
//  CameraHandler
//
//  Created by Kishan Suthar on 25/05/20.
//  Copyright © 2020 Kishan Suthar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imgProfile.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        imgProfile.layer.borderWidth = 0.5
        imgProfile.layer.cornerRadius = 5.0
        imgProfile.clipsToBounds = true
    }

    @IBAction func btnSelectProfileAction(_ sender: UIButton) {
        openCameraPopup()
    }
    
    func openCameraPopup(){
        DispatchQueue.main.async {
            let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cameraAction: UIAlertAction = UIAlertAction(title: "Capture a New Photo", style: .default) { action -> Void in
                
                if UIImagePickerController.isSourceTypeAvailable(.camera) {
                    
                    self.picker.delegate = self
                    self.picker.sourceType = .camera;
                    self.picker.allowsEditing = false
                    self.present(self.picker, animated: true, completion: nil)
                }else {
                }
            }
            let libraryAction: UIAlertAction = UIAlertAction(title: "Select from Gallery", style: .default) { action -> Void in
                
                if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
                    
                    self.picker.delegate = self
                    self.picker.sourceType = .photoLibrary;
                    self.picker.allowsEditing = false
                    self.present(self.picker, animated: true, completion: nil)
                }
            }
            
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            }
            
            actionSheetController.addAction(cameraAction)
            actionSheetController.addAction(libraryAction)
            actionSheetController.addAction(cancelAction)
            self.present(actionSheetController, animated: true, completion: nil)
        }
    }
    
}

extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        DispatchQueue.main.async {
            self.imgProfile.image = image
        }
        //self.isImageChange = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

