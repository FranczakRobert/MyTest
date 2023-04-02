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
        db.collection(Constants.FireStore.collectionName).getDocuments { querySnapshot, error in
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
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    
    
    @IBAction func sendMessagePressed(_ sender: UIButton) {
        
         if let msgBody = messageTextfield.text, let author = Auth.auth().currentUser?.email {
             db.collection(Constants.FireStore.collectionName).addDocument(data:[
                Constants.FireStore.senderFiled : author,
                Constants.FireStore.bodyFiled   : msgBody,
                Constants.FireStore.dataField   : CACurrentMediaTime()
             ]){(error) in
                 if let e = error {
                     print( "SIE SPIERDOLILO COS: \(e.localizedDescription)")
                 } else {
                     print("WSZYSTKO CACY POSZLO BYCZKQ")
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
        
        // create cell
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellID, for: indexPath) as! MessageCell
        
        cell.label.text = "\(messages[indexPath.row].body)"
        
        return cell
    }
}
