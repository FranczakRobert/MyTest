//
//  SuccessViewController.swift
//  RLTest
//
//  Created by Robert Franczak on 14/03/2023.
//

import UIKit
import Firebase



class SuccessViewController: UIViewController {
    
    let db = Firestore.firestore()
    
    @IBOutlet weak var messageTextfield: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [Message] = []
    
    override func viewDidLoad() {
        //tableView.delegate = self
        tableView.dataSource = self
        title = Constants.appName
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        
        tableView.register(UINib(nibName: Constants.cellNibname, bundle: nil), forCellReuseIdentifier: Constants.cellID)
        
        loadMessages()
    }
    
    func loadMessages() {
        
        db.collection(Constants.FireStore.collectionName)
            .order(by:"date")
            .addSnapshotListener { querySnapshot, error in
                self.messages = []
            if let safeError = error {
                print("Read data - failed \(safeError)")
            }
            else {
                if let queryDocument = querySnapshot?.documents {
                    for doc in queryDocument {
                        let document = doc.data()
                        if let senderMsg = document[Constants.FireStore.senderFiled] as? String , let bodyMsg = document[Constants.FireStore.bodyFiled] as? String {
                            let newMessage = Message(sender: senderMsg, body: bodyMsg)
                            self.messages.append(newMessage)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        
         if let msgBody = messageTextfield.text, let author = Auth.auth().currentUser?.email {
             if msgBody.prefix(1) != " " && msgBody.count > 0 {
                 db.collection(Constants.FireStore.collectionName).addDocument(data:[
                    Constants.FireStore.senderFiled : author,
                    Constants.FireStore.bodyFiled   : msgBody,
                    Constants.FireStore.dateField   : Date().timeIntervalSince1970
                 ]){(error) in
                     if let e = error {
                         print( "SIE SPAPRALO COS: \(e.localizedDescription)")
                     } else {
                         print("WSZYSTKO CACY POSZLO")
                         self.messageTextfield.text = ""
                     }
                 }
             }
             
        }
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! MessageCell
        
        let particularMessage = messages[indexPath.row]
        
        if particularMessage.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = .systemMint
            cell.label.textAlignment = .right
        }
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = .systemCyan
            cell.label.textAlignment = .left
        }
        
        cell.label.text = "\(messages[indexPath.row].body)"
        
        return cell
    }
}
