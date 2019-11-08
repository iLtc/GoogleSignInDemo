//
//  ViewController.swift
//  GoogleSignInDemo
//
//  Created by Alan Luo on 11/6/19.
//  Copyright © 2019 iLtc. All rights reserved.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        // GIDSignIn.sharedInstance()?.restorePreviousSignIn()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let _ = UserDefaults.standard.string(forKey: "userId") {
            performSegue(withIdentifier: "showDetails", sender: nil)
        }
    }


}
