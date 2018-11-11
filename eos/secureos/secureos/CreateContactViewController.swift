//
//  CreateContactViewController.swift
//  secureos
//
//  Created by Danilo on 11/11/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import UIKit

class CreateContactViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var selectDocumentButton: UIButton!
    
    lazy var imagePicker = UIImagePickerController()
    var mainViewController: ViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barStyle = .blackOpaque
        self.imagePicker.delegate = self
    }

    @IBAction func closeButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addContactPushed(_ sender: Any) {
        self.mainViewController?.showConfirmation = true
        
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        loadingIndicator.startAnimating()
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10, execute: {
            self.dismiss(animated: false, completion: {
                self.dismiss(animated: true, completion: nil)
            })
        } )
    }
    
    @IBAction func addDocumentPushed(_ sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let _ = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.selectDocumentButton.isEnabled = false
            self.selectDocumentButton.backgroundColor = UIColor(red: (9/255.0), green: (148/255.0), blue: (65/255.0), alpha: 1.0) 
            self.selectDocumentButton.setTitle("Document retrieved", for: .normal)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion:nil)
    }

}
