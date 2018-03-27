//
//  Chat.swift
//  Storagen_partNik
//
//  Created by Nik Suprunov on 3/12/18.
//  Copyright © 2018 Nik Suprunov. All rights reserved.
//

import UIKit
import LBTAComponents

class Chat: UITableViewController {

    
    var arrayka = ["Kyle"]
    
    

    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]

        
        tableView.register(chatCell.self, forCellReuseIdentifier: "chatCell")
        
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath)
        cell.selectionStyle = .none
        // Configure the cell...

        
        let size = CGSize(width: 250,  height:1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string:  "CUSTOM").boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18)], context: nil)
        
      
        
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
    
    let name: UITextView = {
     let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 22)
        textView.backgroundColor = UIColor.clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.isSelectable = false
        textView.text = "KYLE"
        return textView
        
        
    }()
    
    
    
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .red
        
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
