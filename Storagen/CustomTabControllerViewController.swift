//
//  CustomTabControllerViewController.swift
//  Storagen
//
//  Created by Kyle Ohanian on 3/26/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit

class CustomTabControllerViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let propsController = UINavigationController(rootViewController: PropertiesController())
        propsController.tabBarItem.image = #imageLiteral(resourceName: "ic_properties.png")
        propsController.tabBarItem.title = "Properties"
        let chatController = UINavigationController(rootViewController: Chat())
        propsController.tabBarItem.title = "Chat"
        viewControllers = [ chatController]
        // Do any additional setup after loading the view.
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