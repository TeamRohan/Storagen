//
//  Chatter.swift
//  Storagen_partNik
//
//  Created by Nik Suprunov on 3/14/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class Chatter: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ref: DatabaseReference!

    var bottomConstraint: NSLayoutConstraint?
    var conversator: chatUser!
    
    var arrayka = [ChatClass]()
    
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Send", for: .normal)
        let titleColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
        button.setTitleColor(titleColor, for: UIControlState.normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        return button
    }()
    let inputTextField: UITextField = {
        let textField = UITextField()
        
        textField.textColor = UIColor.white

        return textField
    }()
    
    
    let bottom: UIView = {
       let v = UIView()
        
        v.backgroundColor = UIColor(displayP3Red: 13/255, green: 12/255, blue: 18/255, alpha: 1)
        
        return v
        
    }()
    
    
    
    let tableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

       
        self.tabBarController?.tabBar.isHidden = true

        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        tableView.separatorInset = UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
        tableView.register(message.self, forCellReuseIdentifier: "message")
        setupUI()
        
    
        self.navigationItem.title = conversator.mail
            self.view.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        self.tableView.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
   
        fetchMessages()
        
        
    }
    
    
    func fetchMessages() {
        ref.child("Users").child((Auth.auth().currentUser?.uid)!).child("Chats").child(conversator.id).observe(.value, with: {(snapshot) in
            
            
            guard let value = snapshot.value as? NSDictionary else { return }
            self.arrayka = []
            let enumerator = snapshot.children

            while let rest = enumerator.nextObject() as? DataSnapshot {
                if let object = rest.value as? [String: Any] {
                    let A = object["A"] as! String
                    let B = object["B"] as! String
                    let C = object["message"] as! String
                    
                    let newMessage = ChatClass(personA: A, personB: B, message: C)
                    self.arrayka.append(newMessage)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                    
            }
            }
            
           /* for (id, obj) in value {
                
            
                
                 if let object = obj as? [String: Any] {
                    
                    let A = object["A"] as! String
                    let B = object["B"] as! String
                    let C = object["message"] as! String
                    
                    let newMessage = ChatClass(personA: A, personB: B, message: C)
                    self.arrayka.append(newMessage)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
                
            }*/
            
        }
        )}
        
    
    
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        var keyboardHeight = CGFloat(0)
        if let userInfo = notification.userInfo {
            if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
let keyboardRectangle = keyboardFrame.cgRectValue
                keyboardHeight = keyboardRectangle.height
                
            }
            
            let isKeyboardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            if isKeyboardShowing {
                bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0
                if self.arrayka.count != 0 {
                let indexPath = IndexPath(item: self.arrayka.count-1, section: 0)
                
                
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                }
            }
            
            else {
                
                bottomConstraint?.constant = isKeyboardShowing ? -keyboardHeight : 0

            }
            
            
            
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutSubviews()
                self.view.layoutIfNeeded()
                
            }, completion: { (completed) in
                
        
                
            })
            
        }
     
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func setupUI() {
        self.navigationController?.navigationBar.tintColor = .black
        view.addSubview(tableView)
        view.addSubview(bottom)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        bottom.translatesAutoresizingMaskIntoConstraints = false
    //    tableView.translatesAutoresizingMaskIntoConstraints = false
         bottomConstraint = NSLayoutConstraint(item: bottom, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        
        view.addConstraint(bottomConstraint!)
        
        [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            
            // table.heightAnchor.constraint(equalTo: view.heightAnchor,constant:-75),
            tableView.bottomAnchor.constraint(equalTo: self.bottom.topAnchor, constant: 0),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
            ].forEach({$0.isActive = true})
        
        bottom.heightAnchor.constraint(equalToConstant: 75).isActive = true
        bottom.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottom.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        bottom.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
      
        
        
        bottom.addSubview(sendButton)
        bottom.addSubview(inputTextField)
        
        inputTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        [
            
            inputTextField.topAnchor.constraint(equalTo: bottom.topAnchor),
            inputTextField.heightAnchor.constraint(equalTo: bottom.heightAnchor),
            inputTextField.leftAnchor.constraint(equalTo: view.leftAnchor),
            inputTextField.rightAnchor.constraint(equalTo: view.rightAnchor,constant:-75)
            ].forEach({$0.isActive = true})
        
        
        [
            
            sendButton.topAnchor.constraint(equalTo: bottom.topAnchor),
            sendButton.heightAnchor.constraint(equalTo: bottom.heightAnchor),
            sendButton.leftAnchor.constraint(equalTo: inputTextField.rightAnchor),
            sendButton.rightAnchor.constraint(equalTo: view.rightAnchor)
            ].forEach({$0.isActive = true})
        sendButton.addTarget(self, action: #selector(sendMessage), for: UIControlEvents.touchUpInside)

        
    }
    
    
   @objc func sendMessage() {
    
    if inputTextField.text != "" {
    
        let message = ["A":Auth.auth().currentUser?.uid, "B":conversator.id, "message": inputTextField.text] as [String : Any]
        
        
        let toPut = ref.child("Users").child((Auth.auth().currentUser?.uid)!).child("Chats").child(conversator.id).childByAutoId()
        let toPut2 = ref.child("Users").child(conversator.id).child("Chats").child((Auth.auth().currentUser?.uid)!).childByAutoId()

        toPut.setValue(message)
        toPut2.setValue(message)
        
        inputTextField.text = ""
    
        
        
    }
    
        
    }
    
    
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayka.count
    }

    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "message", for: indexPath) as! message

   // cell.textLabel?.text = String(describing: indexPath.row)
    
    cell.selectionStyle = .none
    
    let size = CGSize(width: 250,  height:1000)
    let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
    let estimatedFrame = NSString(string: arrayka[indexPath.row].message).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
    
    
    
    if (arrayka[indexPath.row].personA == Auth.auth().currentUser?.uid ) {
        cell.messageTextView.frame = CGRect(x:view.frame.maxX-48-8-20-estimatedFrame.width
            , y:0, width:estimatedFrame.width + 16, height:estimatedFrame.height + 15)
        cell.boolFlag = true
        
        
        
        cell.messageTextView.text = arrayka[indexPath.row].message
    }
    else {
    
    
    cell.messageTextView.text = arrayka[indexPath.row].message
    cell.messageTextView.frame = CGRect(x:48 + 8, y:0, width:estimatedFrame.width + 16, height:estimatedFrame.height + 15)
        
cell.changeReceiver()
    }
  
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = arrayka[indexPath.row].message
        
        
        let size = CGSize(width:250, height:1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: message).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
        return estimatedFrame.height+30
    }

 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



class message: UITableViewCell {
    
    
    
    var tempAncor: NSLayoutConstraint?
    
    var boolFlag: Bool! {
        didSet {

        greyBubble.removeFromSuperview()
        avatarImgUrl.removeFromSuperview()
            self.addSubview(myAvatar)
            self.addSubview(blueBubble)
            
            myAvatar.anchor(nil, left: nil, bottom: self.messageTextView.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 30, heightConstant: 30)
            
            
            [ blueBubble.leftAnchor.constraint(equalTo: self.messageTextView.leftAnchor, constant:-5),
              blueBubble.rightAnchor.constraint(equalTo: self.myAvatar.leftAnchor, constant: -5),
               blueBubble.topAnchor.constraint(equalTo: self.topAnchor),
              blueBubble.bottomAnchor.constraint(equalTo: self.messageTextView.bottomAnchor,constant: 0)].forEach({$0.isActive = true})
            
            self.addSubview(messageTextView)
            self.layoutIfNeeded()
            
        }
    }
    

    
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
    //    textView.text = "Sample message"
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = UIColor.clear
        return textView
    }()
 
       static let grayBubbleImage = UIImage(named: "bubble_gray")!.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    static let blueBubbleImage = UIImage(named: "bubble_blue")!.resizableImage(withCapInsets: UIEdgeInsetsMake(22, 26, 22, 26)).withRenderingMode(.alwaysTemplate)
    
    
    var avatarImgUrl: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        img.backgroundColor = .blue
        return img
    }()
    var greyBubble: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = grayBubbleImage
        img.tintColor = UIColor(white: 0.90, alpha: 1)
        return img
    }()
    var myAvatar: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.contentMode = .scaleAspectFill
        img.layer.cornerRadius = 15
        img.layer.masksToBounds = true
        img.backgroundColor = .blue
        return img
    }()
    var blueBubble: UIImageView = {
        var img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = blueBubbleImage
        return img
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
             self.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        
        
   
myAvatar.removeFromSuperview()
        blueBubble.removeFromSuperview()
        self.addSubview(avatarImgUrl)
        self.addSubview(greyBubble)
        self.addSubview(messageTextView)
       // self.addSubview(blueBubble)
        
        
      
        avatarImgUrl.anchor(nil, left: self.leftAnchor, bottom: self.messageTextView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        
        [ greyBubble.leftAnchor.constraint(equalTo: self.avatarImgUrl.rightAnchor, constant:5),
          greyBubble.rightAnchor.constraint(equalTo: self.messageTextView.rightAnchor, constant: 10),
          greyBubble.topAnchor.constraint(equalTo: self.topAnchor),
          greyBubble.bottomAnchor.constraint(equalTo: self.messageTextView.bottomAnchor,constant: 0)].forEach({$0.isActive = true})

        greyBubble.image = message.grayBubbleImage
        
    }


    
     func changeReceiver() {
    
        myAvatar.removeFromSuperview()
        blueBubble.removeFromSuperview()
        self.addSubview(avatarImgUrl)
        self.addSubview(greyBubble)
        self.addSubview(messageTextView)
        // self.addSubview(blueBubble)
        
        
        
        avatarImgUrl.anchor(nil, left: self.leftAnchor, bottom: self.messageTextView.bottomAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 30, heightConstant: 30)
        
        
        [ greyBubble.leftAnchor.constraint(equalTo: self.avatarImgUrl.rightAnchor, constant:5),
          greyBubble.rightAnchor.constraint(equalTo: self.messageTextView.rightAnchor, constant: 10),
          greyBubble.topAnchor.constraint(equalTo: self.topAnchor),
          greyBubble.bottomAnchor.constraint(equalTo: self.messageTextView.bottomAnchor,constant: 0)].forEach({$0.isActive = true})
        
        greyBubble.image = message.grayBubbleImage
        
        print("RECEIVER")
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

