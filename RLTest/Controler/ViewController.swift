//
//  ViewController.swift
//  RLTest
//
//  Created by Robert Franczak on 14/03/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    let titleText = Constants.appName
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textLabel.text = ""
        var counter = 0.0
        
        for i in titleText {
            
            Timer.scheduledTimer(withTimeInterval: 0.1 * counter, repeats: false) { timer in
                self.textLabel.text! += String(i)
            }
            counter += 1
        }
    }
}
