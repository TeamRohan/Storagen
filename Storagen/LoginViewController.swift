//
//  LoginViewController.swift
//  Storagen
//
//  Created by Rohan Gupta on 3/20/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var email: UILabel!
    @IBOutlet var password: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func submitButtonPressed(_ sender: Any) {
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
        else {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: "Could not sign in", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                        
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                
            }
        }
        
    }
    @IBAction func forgotButtonPressed(_ sender: Any) {
    }
    
    @IBAction func noAccountButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "registerTransistion", sender: nil)
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
