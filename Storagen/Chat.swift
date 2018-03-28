//
//  Chat.swift
//  Storagen_partNik
//
//  Created by Nik Suprunov on 3/12/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import LBTAComponents

class Chat: UITableViewController {

    
    var arrayka = [chatUser]()
    
    var ref: DatabaseReference!

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        self.tableView.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        
        ref = Database.database().reference()

 navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        self.navigationItem.title = "Chats"

        tableView.separatorColor = .black

        tableView.register(chatCell.self, forCellReuseIdentifier: "chatCell")
        fetchData()
        
    }
    
    

    
    func fetchData() {
        ref.child("Users").child((Auth.auth().currentUser?.uid)!).child("Conversations").observe( .value, with:
            { (snapshot) in
                self.arrayka = []
                guard let value = snapshot.value as? NSDictionary else { return }
                for (id, obj) in value {
                    if let userId = id as? String {
                        self.ref.child("Users").child(userId).child("mail").observe(.value, with: {(snapshot)
                            in
                    let lol = chatUser(id: userId, mail: snapshot.value as! String, name: "")
                            self.arrayka.append(lol)
                            self.tableView.reloadData()
                            
                            
                        })
                        
                    }
             
              
                }
                
            
        })
        { (error) in
            print(error.localizedDescription)
        }
        
    }

  

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source



    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrayka.count
    }

    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! chatCell
        cell.selectionStyle = .none
        // Configure the cell...

        
        let size = CGSize(width: 250,  height:1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string:  "CUSTOM").boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
      cell.name.text = arrayka[indexPath.row].mail
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let navi = Chatter()
        
        
        navi.conversator = arrayka[indexPath.row]
        
        self.navigationController?.pushViewController(navi, animated: true)
    
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }


}

class chatCell: UITableViewCell {
    
    
    
    
    let heightForImg = 75
    
    let profImg: UIImageView = {
        let img = UIImageView()
        
        
        img.layer.borderWidth = 1
        img.layer.masksToBounds = false
        img.layer.borderColor = UIColor.black.cgColor
        img.clipsToBounds = true
        img.backgroundColor = .blue
        img.layer.cornerRadius = 75/2
        return img
        
    }()
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        
        return textView
    }()
    
    var name: UITextView = {
     let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 22)
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textColor = .white
        textView.isSelectable = false
        return textView
        
        
    }()
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor(displayP3Red: 21/255, green: 24/255, blue: 33/255, alpha: 1)
        
        
        setupCellUI()
        
    }
    
  
    func setupCellUI() {
        
        self.addSubview(profImg)
        self.addSubview(name)
        
        
        profImg.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 75, heightConstant: 75)
        
        name.anchor(self.topAnchor, left: self.profImg.rightAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)

    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
