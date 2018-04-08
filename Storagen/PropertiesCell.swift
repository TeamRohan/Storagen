//
//  PropertiesCell.swift
//  Storagen
//
//  Created by Kyle Ohanian on 3/24/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase
import FirebaseDatabase

class PropertiesCell: UITableViewCell {
    
    
    @IBOutlet weak var propertyAddress: UILabel!
    @IBOutlet weak var propertySize: UILabel!
    @IBOutlet weak var propertyDescription: UILabel!
    @IBOutlet weak var propertyImage: UIImageView!
    @IBOutlet weak var sView: UIView!
    
    var navController: UINavigationController!
    
    var property: Property!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let opaqueColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.7)
        self.contentView.layer.backgroundColor = opaqueColor.cgColor
        self.sView.layer.cornerRadius = 16
        self.contentView.layer.cornerRadius = 16
        let xPos = self.contentView.layer.position.x
        let yPos = self.contentView.layer.position.y
        let w = self.contentView.frame.width
        let h = self.contentView.frame.height
        let selectedView = UIView(frame: CGRect(x: xPos, y: yPos, width: w, height: h))
        selectedView.backgroundColor = opaqueColor
        selectedView.layer.cornerRadius = 16
        self.selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindObject(obj: Property) {
        self.property = obj
        self.propertyAddress.text = obj.propertyAddress
        self.propertySize.text = obj.propertySize
        self.propertyDescription.text = obj.propertyDescription
        self.propertyImage.af_setImage(withURL: obj.propertyImageUrl!)
    }
    @IBAction func onUpdate(_ sender: Any) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Nikhil", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AddNewController") as! AddANewPropertyViewController
        vc.currentProperty = property
        navController?.pushViewController(vc, animated: true)
    }
    
}
