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
import FirebaseDatabase


class RegisterViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var name: UITextField!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    var ref: DatabaseReference!
    
    
    @IBAction func registerButtonPressed(_ sender: Any) {
        var stringEmail = email.text as! String
        let character: Character = "@"
        if(email.text == nil) {
            let alertController = UIAlertController(title: "Error", message: "Please enter email", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if(!stringEmail.characters.contains(character)) {
            let alertController = UIAlertController(title: "Error", message: "Email must be valid", preferredStyle: .alert)
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
        else if((password.text?.characters.count)! < 7) {
            print("Password is not appropriate length")
            let alertController = UIAlertController(title: "Error", message: "Password must be seven characters long", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            
        }
        /*else if(email.text != confirmEmail.text) {
            let alertController = UIAlertController(title: "Error", message: "Emails do not match", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }*/
        else if(password.text != confirmPassword.text) {
            let alertController = UIAlertController(title: "Error", message: "Passwords do not match", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            print("Reached here")
            print(email.text)
            print(password.text)
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: "Cannot register user", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                        
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    
                    
                    
                    
                    guard let uid = user?.uid else { return }
                    
                    let toPutHere = self.ref.child("Users").child(uid)
                    toPutHere.child("mail").setValue(self.email.text)
                    toPutHere.child("name").setValue(self.name.text)
                    
                    
                    let alertController = UIAlertController(title: "Successful", message: "Successfully registered", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    }
                    alertController.addAction(okAction)
                    DispatchQueue.main.async {
                        
                        
                        self.present(alertController, animated: true, completion: nil)
                        self.navigationController?.popViewController(animated: true)
                        
                    }
                }
            }
        }
//        self.performSegue(withIdentifier: "loginTransistion", sender: nil)
        
    }
    
    
    @objc func goBack() {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    let backButton: UIButton = {
        let but = UIButton()
        
        but.isUserInteractionEnabled = true
        but.translatesAutoresizingMaskIntoConstraints = false
        
        but.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return but
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        
        ref = Database.database().reference()
        
        
        view.addSubview(backButton)
        
        [backButton.topAnchor.constraint(equalTo: view.topAnchor),
         backButton.heightAnchor.constraint(equalToConstant: 50),
         backButton.widthAnchor.constraint(equalToConstant: 50),
         backButton.leftAnchor.constraint(equalTo: view.leftAnchor
            )].forEach({$0.isActive = true})
        
        backButton.backgroundColor = .black
        backButton.setTitle("Back", for: .normal)
        
        
        
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
