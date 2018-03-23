//
//  RegisterViewController.swift
//  Storagen
//
//  Created by Rohan Gupta on 3/20/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var email: UILabel!
    @IBOutlet var confirmEmail: UILabel!
    @IBOutlet var password: UILabel!
    @IBOutlet var confirmPassword: UILabel!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        if(email.text == nil) {
            let alertController = UIAlertController(title: "Error", message: "Please enter email", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(password.text == nil) {
            let alertController = UIAlertController(title: "Error", message: "Please enter password", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(email.text != confirmEmail.text) {
            let alertController = UIAlertController(title: "Error", message: "Emails do not match", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(password.text != confirmPassword.text) {
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: "Cannot sign in", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                        
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
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
