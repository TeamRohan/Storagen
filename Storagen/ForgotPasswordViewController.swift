//
//  ForgotPasswordViewController.swift
//  NewStoragen
//
//  Created by Rohan Gupta on 3/25/18.
//  Copyright © 2018 Rohan Gupta. All rights reserved.
//
import UIKit
import Firebase
import FirebaseAuth

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        print("Submit pressed")
        Auth.auth().sendPasswordReset(withEmail: emailText.text!) { (error) in
            print("Reached inside password")
            if let error = error {
                let alertController = UIAlertController(title: "Error", message: "Cannot reset password. Please enter email again", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                print("successful")
                let alertController = UIAlertController(title: "Successful", message: "A verification email has been sent", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
            
        }
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
