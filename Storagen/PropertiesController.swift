//
//  PropertiesController.swift
//  Storagen
//
//  Created by Kyle Ohanian on 3/23/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase


class PropertiesController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var CELL_PADDING = 20 as CGFloat
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return properties.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CELL_PADDING
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let propertyCell = self.propertiesTableView.dequeueReusableCell(withIdentifier: "propertyCell" ,for:indexPath) as! PropertiesCell
        propertyCell.selectionStyle = .default
        propertyCell.bindObject(obj: properties[indexPath.row])
        return propertyCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        propertiesTableView.deselectRow(at: indexPath, animated: false)
    }

    @IBOutlet weak var propertiesTableView: UITableView!
    
    var properties: [Property] = []
    var ref: DatabaseReference!
    var pref: StorageReference!
    
    let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(PropertiesController.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        pref = Storage.storage().reference()
        propertiesTableView.delegate = self
        propertiesTableView.dataSource = self
        self.propertiesTableView.addSubview(self.refreshControl)
        self.propertiesTableView.separatorStyle = .none
        getProperties()
    }
    
    
    func getProperties() {
        properties.removeAll()
        ref.child("Properties").observeSingleEvent(of: .value, with:
            { (snapshot) in
                let value = snapshot.value as? NSDictionary
                for (id, obj) in value! {
                    let propId = id as! String
                    let dictVals = obj as! [String: Any]
                    let property = Property(propertyId: propId, dictionary: dictVals)
                    print(property.toString())
                    self.properties.append(property)
                }
                self.propertiesTableView.reloadData()
                if(self.refreshControl.isRefreshing) {
                    self.refreshControl.endRefreshing()
                }
            })
            { (error) in
                print(error.localizedDescription)
            }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        getProperties()
        self.propertiesTableView.reloadData()
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
