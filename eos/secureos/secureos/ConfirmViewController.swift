//
//  ConfirmViewController.swift
//  secureos
//
//  Created by Danilo on 11/11/2018.
//  Copyright © 2018 Danilo Raspa. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func confirmButtonPushed(_ sender: Any) {
        let alert = UIAlertController(title: "", message: "Confirmed", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
