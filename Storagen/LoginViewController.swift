import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        var stringEmail = email.text as! String
        var stringPassword = password.text as! String
        let character: Character = "@"
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
        else if(!stringEmail.characters.contains(character)) {
            print("Not valid email")
            let alertController = UIAlertController(title: "Error", message: "Email must be valid", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message: "Could not sign in. Please make sure your email and password are correct", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    
                }
                else {
                    print("Successful")
                    print(user)
//                    let alertController = UIAlertController(title: "Successful", message: "Successfully signed in", preferredStyle: .alert)
//                    let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
//                    }
//                    alertController.addAction(okAction)
//                    self.present(alertController, animated: true, completion: nil)
                    let mainView: UIStoryboard = UIStoryboard(name: "MainPageStoryboard", bundle: nil)
                //    let mainPageController = mainView.instantiateInitialViewController()
                 //   self.present(mainPageController!,animated: false, completion: nil)
                    
                    let custom = CustomTabControllerViewController()
                    self.present(custom,animated: true, completion: nil)
                    
                }
                
            }
        }
        
    }
    @IBAction func forgotButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "forgotPasswordTransistion", sender: nil)
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
