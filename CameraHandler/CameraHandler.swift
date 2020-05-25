//
//  CameraHandler.swift
//  CameraHandler
//
//  Created by Kishan Suthar on 25/05/20.
//  Copyright © 2020 Kishan Suthar. All rights reserved.
//

import Foundation
import UIKit

class CameraHandler: NSObject {
    static let shared = CameraHandler()
    fileprivate var currentVC: UIViewController!
    
    //MARK: Internal Properties
    var imagePickedBlock: ((UIImage) -> Void)?
    
    func camera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            DispatchQueue.main.async {
                self.currentVC.present(myPickerController, animated: true, completion: nil)
            }
        } else {
            self.photoLibrary()
        }
    }
    
    func photoLibrary()
    {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            DispatchQueue.main.async {
                self.currentVC.present(myPickerController, animated: true, completion: nil)
            }
        } else {
        }
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Take Picture", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Select From Photo Library", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        if let popoverController = actionSheet.popoverPresentationController {
            popoverController.sourceView = currentVC.view
            popoverController.sourceRect = CGRect(x: currentVC.view.bounds.midX, y: currentVC.view.bounds.midY / 2, width: 0, height: 0)
        }
        DispatchQueue.main.async {
            vc.present(actionSheet, animated: true, completion: nil)
        }
    }
}


extension CameraHandler: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imagePickedBlock?(image)
        } else {
        }
        currentVC.dismiss(animated: true, completion: nil)
    }
    
}
