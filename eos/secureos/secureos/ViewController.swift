//
//  ViewController.swift
//  secureos
//
//  Created by Danilo on 11/11/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var addContactButton: UIButton!
    @IBOutlet weak var signatureALabel: UILabel!
    @IBOutlet weak var hashDocumentLabel: UILabel!
    @IBOutlet weak var signatureBLabel: UILabel!
    
    var showConfirmation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImageView.layer.masksToBounds = true
        self.profileImageView.layer.cornerRadius = 50
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if (showConfirmation) {
            self.addContactButton.backgroundColor = UIColor(red: (9/255.0), green: (148/255.0), blue: (65/255.0), alpha: 1.0)
            self.addContactButton.setTitle("Confirm", for: .normal)
            self.signatureALabel.text = "oP4IfJSw+RCXwLbZg2Nk3Yb/Z7FeIBQ="
            self.hashDocumentLabel.text = "Twiwao4owMtA90hP8dTx0EBAmVHoDyY="
            self.signatureBLabel.text = "gFZShBVj+MY3QHS2hANPYW1QaLpio="
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    @IBAction func newEmergencyContactPushed(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        if (showConfirmation) {
                        
            let controller = storyboard.instantiateViewController(withIdentifier: "wellDoneController")
            self.present(controller, animated: true, completion: nil)
        } else {
            
            let controller = storyboard.instantiateViewController(withIdentifier: "contactNavigationController") as! UINavigationController
            if let createContactController = controller.viewControllers.first as? CreateContactViewController {
                createContactController.mainViewController = self
            }
            
            self.present(controller, animated: true, completion: nil)
        }
    }
}

