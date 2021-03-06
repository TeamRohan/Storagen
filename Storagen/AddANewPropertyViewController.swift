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
import FirebaseDatabase
import CoreLocation
import MapKit
import RSKPlaceholderTextView
import SwiftyUUID


class AddANewPropertyViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    
    @IBOutlet weak var propertySizeTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var endDateTextView: RSKPlaceholderTextView!
    @IBOutlet weak var startDateTextView: RSKPlaceholderTextView!
    @IBOutlet weak var propertImageView: UIImageView!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pricePerNightTextField: UITextField!
    
    var properAddress = "";
    
    let datePicker = UIDatePicker();
    let datePicker2 = UIDatePicker();
    
    var currentImage: UIImage?
    
    var ref: DatabaseReference!
    var pref: StorageReference!
    
    var currentProperty: Property!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.black
        
        ref = Database.database().reference()
        pref = Storage.storage().reference()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black]
        
        startDateTextView.clipsToBounds = true;
        startDateTextView.layer.cornerRadius = 4;
        
        endDateTextView.clipsToBounds = true;
        endDateTextView.layer.cornerRadius = 4;
        
        propertySizeTextField.attributedPlaceholder = NSAttributedString(string: "60 x 60", attributes: [NSAttributedStringKey.foregroundColor: startDateTextView.placeholderColor])
        
        addressTextField.attributedPlaceholder = NSAttributedString(string: "1165, West Stadium Ave, IN 47906", attributes: [NSAttributedStringKey.foregroundColor: startDateTextView.placeholderColor])
        
        descriptionTextField.attributedPlaceholder = NSAttributedString(string: "Great building", attributes: [NSAttributedStringKey.foregroundColor: startDateTextView.placeholderColor])
        
        pricePerNightTextField.attributedPlaceholder = NSAttributedString(string: "$20", attributes: [NSAttributedStringKey.foregroundColor: startDateTextView.placeholderColor])
        
        propertImageView.clipsToBounds = true;
        propertImageView.layer.cornerRadius = 4;
        
        
        createDatePicker();
        createDatePicker2();
        
        guard let newProp = currentProperty else { return }
        propertySizeTextField.text = newProp.propertySize
        addressTextField.text = newProp.propertyAddress
        descriptionTextField.text = newProp.propertyDescription
        endDateTextView.text = newProp.propertyEndDate
        startDateTextView.text = newProp.propertyStartDate
        pricePerNightTextField.text = newProp.propertyPrice
        propertImageView.af_setImage(withURL: newProp.propertyImageUrl!)
        navigationItem.title = "Update Property"
        
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
        
        guard let propertyTest = propertySizeTextField.text, !propertyTest.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter a property", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let addressTest = addressTextField.text, !addressTest.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter address", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let descriptionTest = descriptionTextField.text, !descriptionTest.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter description", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let priceTest = pricePerNightTextField.text, !priceTest.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter price", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let startTest = startDateTextView.text, !startTest.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter start date", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        guard let endTest = endDateTextView.text, !endTest.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter end date", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        
        
        //let propertyRef = pref.child("images/property.jpg");
        guard let img = propertImageView.image else {
            let alertController = UIAlertController(title: "Error", message: "Please add image", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default) { (action) in
                
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
        let uploadData = UIImagePNGRepresentation(img)
        
        let uuid = SwiftyUUID.UUID()
        
        let uuidString = uuid.CanonicalString()
        
        
        pref.child(uuidString).putData(uploadData!, metadata: nil, completion: {(metadata, error) in
            let imageUrl = metadata?.downloadURL()?.absoluteString
            //if(self.singlePhoto == true) {
            //let toPut = ref.child("users").child(userID!).child("userPhoto");
            //let toPut = self.pref.child("userPhoto");
            //toPut.setValue(metadata?.downloadURL()?.absoluteString)
            //self.singlePhoto = false
            //self.viewDidLoad()
            DispatchQueue.main.async {
                
                //TODO: here
                let address = self.addressTextField.text!
                var geocoder = CLGeocoder()
                geocoder.geocodeAddressString(address) {
                    placemarks, error in
                    
                    var lat:CLLocationDegrees
                    var lon:CLLocationDegrees
                    
                    let placemark = placemarks?.first
                    guard let latTemp = (placemark?.location?.coordinate.latitude) else { return }
                    guard let lonTemp = (placemark?.location?.coordinate.longitude) else { return }
                    lat = latTemp
                    lon = lonTemp
                    print("Lat: \(lat), Lon: \(lon)")
                    let values = ["userId": Auth.auth().currentUser?.uid ?? "",
                                  "size": self.propertySizeTextField.text, "address": self.addressTextField.text!, "description": self.descriptionTextField.text!, "startDate": self.startDateTextView.text!, "endDate": self.endDateTextView.text!, "price": self.pricePerNightTextField.text!, "Timestamp": today!, "latitude": String(describing: lat), "longitude": String(describing: lon),
                                  "imageUrl": imageUrl] as [String : Any]
                    let ID2 = SwiftyUUID.UUID()
                    guard let newProp = self.currentProperty else {
                        let IDSTRING = ID2.CanonicalString()
                        self.ref.child("Users").child((Auth.auth().currentUser?.uid)!).child("properties").child(IDSTRING).setValue(values)
                        self.ref.child("Properties").child(IDSTRING).setValue(values)
                        return
                    }
                    self.ref.child("Users").child((Auth.auth().currentUser?.uid)!).child("properties").child(newProp.propertyId).setValue(values)
                    self.ref.child("Properties").child(newProp.propertyId).setValue(values)
                }
                
            }
            //}
        })
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
