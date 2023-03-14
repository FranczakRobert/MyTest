//
//  RegisterViewControler.swift
//  RLTest
//
//  Created by Robert Franczak on 14/03/2023.
//

import UIKit

class RegisterViewControler: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    
    @IBAction func DonePressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "RegisterToSuccess", sender: self)
        
    }
}
