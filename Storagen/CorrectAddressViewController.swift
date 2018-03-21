//
//  CorrectAddressViewController.swift
//  Storagen
//
//  Created by Nikhil Iyer on 3/7/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//
//
//import UIKit
//import GooglePlaces
//
//class CorrectAddressViewController: UIViewController {
//
//    var resultsViewController: GMSAutocompleteResultsViewController?
//    var searchController: UISearchController?
//    var resultView: UITextView?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        resultsViewController = GMSAutocompleteResultsViewController()
//        resultsViewController?.delegate = self
//
//        searchController = UISearchController(searchResultsController: resultsViewController)
//        searchController?.searchResultsUpdater = resultsViewController
//
//        let subView = UIView(frame: CGRect(x: 0, y: 65.0, width: 350.0, height: 45.0))
//
//        subView.addSubview((searchController?.searchBar)!)
//        view.addSubview(subView)
//        searchController?.searchBar.sizeToFit()
//        searchController?.hidesNavigationBarDuringPresentation = false
//
//        navigationController?.navigationBar.isTranslucent = false
//        searchController?.hidesNavigationBarDuringPresentation = false
//
//        // This makes the view area include the nav bar even though it is opaque.
//        // Adjust the view placement down.
//        self.extendedLayoutIncludesOpaqueBars = true
//        self.edgesForExtendedLayout = .
//        top
//
//        // When UISearchController presents the results view, present it in
//        // this view controller, not one further up the chain.
//        definesPresentationContext = true
//    }
//}
//
//// Handle the user's selection.
//extension CorrectAddressViewController: GMSAutocompleteResultsViewControllerDelegate {
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
//                           didAutocompleteWith place: GMSPlace) {
//        searchController?.isActive = false
//        // Do something with the selected place.
//        print("Place name: \(place.name)")
//        print("Place address: \(place.formattedAddress)")
//        print("Place attributions: \(place.attributions)")
//    }
//
//    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
//                           didFailAutocompleteWithError error: Error){
//        // TODO: handle the error.
//        print("Error: ", error.localizedDescription)
//    }
//
//    // Turn the network activity indicator on and off again.
//    func didRequestAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = true
//    }
//
//    func didUpdateAutocompletePredictions(forResultsController resultsController: GMSAutocompleteResultsViewController) {
//        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//    }
//}
//
//
//




//
//  CorrectAddressViewController.swift
//  Storagen
//
//  Created by Nikhil Iyer on 3/7/18.
//  Copyright © 2018 Kyle Ohanian. All rights reserved.
//

import UIKit
import MapKit

class CorrectAddressViewController: UIViewController, CLLocationManagerDelegate{
    
    var resultSearchController:UISearchController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
    }
}


