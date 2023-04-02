//
//  Constants.swift
//  RLTest
//
//  Created by Robert Franczak on 16/03/2023.
//


struct Constants {
    static let registerSegue = "RegisterToSuccess"
    static let loginSegue    = "LoginToSuccess"
    static let appName       = "📱MyTest App"
    static let cellID        = "ReusableCell"
    static let cellNibname   = "MessageCell"
    
    
    struct FireStore {
        static let collectionName = "messages"
        static let senderFiled    = "sender"
        static let bodyFiled      = "body"
        static let dataField      = "data"
    }
}
