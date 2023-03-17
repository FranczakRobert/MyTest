//
//  SuccessViewController.swift
//  RLTest
//
//  Created by Robert Franczak on 14/03/2023.
//

import UIKit
import Firebase
class SuccessViewController: UIViewController {
    
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hi!"),
        Message(sender: "a@b.com", body: "Hello!"),
        Message(sender: "1@2.com", body: "What's up?!")
    ]
    
    override func viewDidLoad() {
        //tableView.delegate = self
        tableView.dataSource = self
        title = Constants.appName
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: Constants.cellNibname, bundle: nil), forCellReuseIdentifier: Constants.cellID)
    }
    
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}

extension SuccessViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! MessageCell
        
        cell.label.text = "\(messages[indexPath.row].body)"
    
        // config this cell
//        var config = UIListContentConfiguration.cell()
//        config.text = "\(messages[indexPath.row].sender)"
//        config.secondaryText = "\(messages[indexPath.row].body)"
//        config.image = UIImage(named: "MeAvatar")
//        cell.contentConfiguration = config
        
        
        return cell
    }
}

//extension SuccessViewController : UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//    }
//}

