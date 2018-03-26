//
//  PropertyDetailController.swift
//  Storagen
//
//  Created by Kyle Ohanian on 3/26/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit

class PropertyDetailController: UIViewController {
    
    var property: Property!

    override func viewDidLoad() {
        super.viewDidLoad()
        
   
    
        let dan = UIBarButtonItem(title: "Chat", style: .done, target: self, action: #selector(chatMe))
        
        self.navigationItem.rightBarButtonItem = dan
        
        // Do any additional setup after loading the view.
    }
    
    @objc func chatMe() {
        
        print("IT DOES SHIT")
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
