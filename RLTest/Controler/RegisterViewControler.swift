//
//  RegisterViewControler.swift
//  RLTest
//
//  Created by Robert Franczak on 14/03/2023.
//

import UIKit
import Firebase

class RegisterViewControler: UIViewController {

    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    @IBAction func DonePressed(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
                else {
                    self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
                }
            }
        }
    }
}
