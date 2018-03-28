//
//  PropertyDetailController.swift
//  Storagen
//
//  Created by Kyle Ohanian on 3/26/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit

class PropertyDetailController: UIViewController {
    
    var property: Property?
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var propertyImage: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        guard let prop = property else { return }
        guard let url = prop.propertyImageUrl else { return }
        print("\(url) has printed")
        print("\(propertyImage): this is the property image")
        addressLabel.text = prop.propertyAddress
        descLabel.text = prop.propertyDescription
        sizeLabel.text = prop.propertySize
        priceLabel.text = prop.propertyPrice
        startDateLabel.text = "\(prop.propertyStartDate)"
        endDateLabel.text = "\(prop.propertyEndDate)"
        ownerLabel.text = prop.propertyOwnerId
        propertyImage.af_setImage(withURL: url)
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
