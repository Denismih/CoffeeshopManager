//
//  ViewController.swift
//  CoffeeshopManager
//
//  Created by Admin on 13.08.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit


class AuthViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func loginTapped(_ sender: Any) {
      performSegue(withIdentifier: "loginSegue", sender: true)
    }
    
    @IBAction func SignUpTapped(_ sender: Any) {
        performSegue(withIdentifier: "loginSegue", sender: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if  segue.identifier == "loginSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.loginMode = sender as! Bool
            }
        }
    }
    
}

