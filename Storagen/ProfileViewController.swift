//
//  ProfileViewController.swift
//  NewStoragen
//
//  Created by Rohan Gupta on 3/26/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//
import UIKit

import Firebase
import FirebaseDatabase
import FirebaseAuth
import LBTAComponents
//Name, email, profile picture, location, update email and password, my properties


var ref: DatabaseReference!
class ProfileViewController: UIViewController {
    
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isUserInteractionEnabled = false
        label.textColor = .white
        return label;
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isUserInteractionEnabled = false
        label.textColor = .white
        return label;
        
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "Address: "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.isUserInteractionEnabled = false
        label.textColor = .white
        return label;
        
    }()
    
    
    let emailText: UITextField =  {
        let text = UITextField()
        text.textColor = .white
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "N/A"
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.isUserInteractionEnabled = false
        //text.isEditing
        
        return text
        
    }()
    
    let nameText:UITextField =  {
        let text = UITextField()
        text.textColor = .white
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "N/A"
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.isUserInteractionEnabled = false
        
        return text
        
    }()
    let addressText:UITextField =  {
        let text = UITextField()
        text.textColor = .white
        text.textAlignment = .left
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "N/A"
        text.font = UIFont.boldSystemFont(ofSize: 18)
        text.isUserInteractionEnabled = false
        
        return text
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.view.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        self.navigationItem.title = "Profile"
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .done, target: self, action: #selector(logOut))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .done, target: self, action: #selector(editing))
        
        ref = Database.database().reference()
        
        fetchEverything()
        setupUI()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI() {
        
        view.addSubview(emailText)
        view.addSubview(emailLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameText)
        view.addSubview(addressLabel)
        view.addSubview(addressText)
        emailLabel.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 75, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 50)
        emailText.anchor(view.topAnchor, left: emailLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 75, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        nameLabel.anchor(emailLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 100, heightConstant: 50)
        nameText.anchor(emailText.bottomAnchor, left: emailLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        addressLabel.anchor(nameText.bottomAnchor, left: view.leftAnchor, bottom: nil, right: nil, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 100, heightConstant: 50)
        addressText.anchor(nameText.bottomAnchor, left: addressLabel.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 30, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 50)
        
        
        
        
    }
    
    @objc func logOut() {
        do {
            let firebaseAuth = Auth.auth()
            
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    
    @objc func doneEditing() {
        self.navigationItem.rightBarButtonItem?.title = "Edit"
        self.navigationItem.rightBarButtonItem?.action = #selector(editing)
        addressText.isUserInteractionEnabled = false
        nameText.isUserInteractionEnabled = false
        emailText.isUserInteractionEnabled = false
        guard let auth = Auth.auth().currentUser?.uid else { return }
        ref.child("Users").child(auth).child("mail").setValue(emailText.text)
        ref.child("Users").child(auth).child("addr").setValue(addressText.text)
        ref.child("Users").child(auth).child("name").setValue(nameText.text)
        
    }
    
    @objc func editing() {
        self.navigationItem.rightBarButtonItem?.title = "Done"
        self.navigationItem.rightBarButtonItem?.action = #selector(doneEditing)
        addressText.isUserInteractionEnabled = true
        nameText.isUserInteractionEnabled = true
        emailText.isUserInteractionEnabled = true
        if (addressText.text == "N/A") {
            addressText.text = ""
            addressText.becomeFirstResponder()
        }
        
    }
    
    
    func fetchEverything() {
        guard let auth = Auth.auth().currentUser?.uid else { return }
        ref.child("Users").child(auth).observe(.value, with:
            { (snapshot) in
                
                
                if let val =  snapshot.value as? NSDictionary {
                    if let name = val["name"] as? String {
                        self.nameText.text = name
                        
                    }
                    if let mail = val["mail"] as? String {
                        self.emailText.text = mail
                    }
                    
                    if let addr = val["addr"] as? String {
                        
                        self.addressText.text = addr
                        
                    }
                    
                }
        }
            
            
        )}
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

