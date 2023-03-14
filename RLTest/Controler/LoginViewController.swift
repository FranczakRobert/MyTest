//
//  LoginViewController.swift
//  RLTest
//
//  Created by Robert Franczak on 14/03/2023.
//

import UIKit

class LoginViewController : UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "LoginToSuccess", sender: self)
    }
    
}
