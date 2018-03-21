//
//  AddANewPropertyViewController.swift
//  Storagen
//
//  Created by Nikhil Iyer on 3/5/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import CoreLocation
import MapKit

class AddANewPropertyViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    

    @IBOutlet weak var propertySizeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var endDateTextView: UITextView!
    @IBOutlet weak var startDateTextView: UITextView!
    @IBOutlet weak var propertImageView: UIImageView!
    
    
    var properAddress = "";
    
    let datePicker = UIDatePicker();
    let datePicker2 = UIDatePicker();
    
    var currentImage: UIImage?
    
    var ref: DatabaseReference!
    var pref: StorageReference!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        pref = Storage.storage().reference()
        
        createDatePicker();
        createDatePicker2();
        
        // Do any additional setup after loading the view.
    }
    
    func createDatePicker(){
        
        datePicker.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit();
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(Done))
        toolbar.setItems([doneButton], animated: false)
        
        startDateTextView.inputAccessoryView = toolbar;
        
        startDateTextView.inputView = datePicker;
        
        startDateTextView.delegate = self
    }
    
    
    func createDatePicker2(){
        datePicker2.datePickerMode = .date
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit();
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(Done2))
        toolbar.setItems([doneButton], animated: false)
        
        endDateTextView.inputAccessoryView = toolbar
        
        endDateTextView.inputView = datePicker2
        
        endDateTextView.delegate = self
        
    }
    
    @objc func Done(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        startDateTextView.text = "\(dateFormatter.string(from: datePicker.date))"
        self.view.endEditing(true)
    }
    
    @objc func Done2(){
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateFormat = "MM/dd/yyyy"
        
        endDateTextView.text = "\(dateFormatter.string(from: datePicker2.date))"
        self.view.endEditing(true)
    }

    @IBAction func addImage(_ sender: UITapGestureRecognizer) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = UIImagePickerControllerSourceType.camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        let size = CGSize(width: 288, height: 288)
        let newImage = resize(image: editedImage, newSize: size)
        
        currentImage = newImage
        propertImageView.image = currentImage
        
        picker.dismiss(animated: true, completion: nil)
        
        //performSegue(withIdentifier: "tagSegue", sender: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func done(_ sender: Any) {
        let today : String!
        today = getTodayString();

        //let propertyRef = pref.child("images/property.jpg");
        guard let img = propertImageView.image else { return }
        let uploadData = UIImagePNGRepresentation(img)
        pref.child("check").putData(uploadData!, metadata: nil, completion: {(metadata, error) in
            //if(self.singlePhoto == true) {
                //let toPut = ref.child("users").child(userID!).child("userPhoto");
            //let toPut = self.pref.child("userPhoto");
            //toPut.setValue(metadata?.downloadURL()?.absoluteString)
                //self.singlePhoto = false
                //self.viewDidLoad()
            //}
        })
        
        let values = ["Property Size": self.propertySizeTextField.text, "Address": self.addressTextField.text!, "Description": self.descriptionTextField.text!, "Start Date": self.startDateTextView.text!, "End Date": self.endDateTextView.text!, "Timestamp": today!] as [String : Any]
        
        self.ref.child("User").child("Nikhil").setValue(values)
    
    }
    
    func getTodayString() -> String{
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        return today_string
    }
    @IBAction func getCorrectAddress(_ sender: UITapGestureRecognizer) {

        self.performSegue(withIdentifier: "getAddress", sender: nil)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getAddress" {
            let viewController = segue.destination as! LocationSearchTable
            viewController.vc = self
        }
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
