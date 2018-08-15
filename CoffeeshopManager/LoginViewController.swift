//
//  LoginViewController.swift
//  CoffeeshopManager
//
//  Created by Admin on 14.08.2018.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var coffeshopName: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var coffeeshopLabel: UILabel!
    
    var loginMode = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        errorLabel.isHidden = true
        //emailTextField.setBottomBorder()
        //passwordTextField.setBottomBorder()
        //coffeshopName.setBottomBorder()
        
        if loginMode {
            coffeeshopLabel.isHidden = true
            coffeshopName.isHidden = true
        } else {
          loginBtn.setTitle("Sign Up", for: .normal)
        }
        
        
    }


    @IBAction func loginBtnTapped(_ sender: Any) {
        guard emailTextField.text != "" else {
            emailTextField.layer.borderWidth = 2
            emailTextField.layer.cornerRadius = 5
            emailTextField.layer.borderColor = UIColor.red.cgColor
            errorLabel.text = "Enter email"
            errorLabel.isHidden = false
            return
        }
        guard passwordTextField.text != "" else {
            passwordTextField.layer.borderWidth = 2
            passwordTextField.layer.cornerRadius = 5
            passwordTextField.layer.borderColor = UIColor.red.cgColor
            errorLabel.text = "Enter password"
            errorLabel.isHidden = false
            return
        }
        
        if loginMode {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if let error = error {
                    self.errorLabel.text = error.localizedDescription
                } else {
                   var isManager = false
                   var cofName = ""
                    Database.database().reference().child("users").child(user!.user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                        if let userDict = snapshot.value as? [String:Any] {
                            if let manager = userDict["isManager"] as? Bool {
                                isManager = manager
                            }
                            if let name = userDict["coffeshopName"] as? String {
                                cofName = name
                            }
                        }
                    })
                    
                    if isManager {
                        // to manager VC
                        self.performSegue(withIdentifier: "toManagerMain", sender: cofName)
                        
                    }else {
                        //to staff VC
                    }
                }
                
            }
        } else {
            guard let cofName = coffeshopName.text, !cofName.isEmpty else {
                coffeshopName.layer.borderWidth = 2
                coffeshopName.layer.cornerRadius = 5
                coffeshopName.layer.borderColor = UIColor.red.cgColor
                errorLabel.text = "Enter coffeeshop name"
                errorLabel.isHidden = false
                return
            }
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                if let error = error {
                    self.errorLabel.text = error.localizedDescription
                } else {
                    Database.database().reference().child("users").child(user!.user.uid).setValue(["isManager":true, "coffeshopName":cofName])
                    self.performSegue(withIdentifier: "toManagerMain", sender: cofName)
                    
                }
            }
        }
        
    }
    @IBAction func emailEdit(_ sender: Any) {
        emailTextField.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func passwordEdit(_ sender: Any) {
        passwordTextField.layer.borderColor = UIColor.clear.cgColor
    }
    @IBAction func coffeshopNameEdit(_ sender: Any) {
         coffeshopName.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toManagerMain" {
            if let managerVC = segue.destination as? ManagerMainViewController {
                managerVC.coffeeshopName = sender as! String
            }
        }
    }
    
}

extension UITextField {
    func setBottomBorder() {
        self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}

