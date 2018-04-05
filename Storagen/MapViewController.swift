import UIKit
import MapKit

final class SchoolAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var property: Property?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String?, property: Property?){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.property = property
        
        super.init()
    }
    
    var region: MKCoordinateRegion{
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}
class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    var properties: [Property]!
    
    var selectedView: MKAnnotationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any  additional setup after loading the view, typically from a nib.
        mapView.delegate = self
        mapView.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        for property in properties {
            let longi = Double(property.propertyLongitude)!
            print("LONGITUDE: \(longi)")
            let propertyCoordinate = CLLocationCoordinate2D(latitude: Double(property.propertyLatitude)!, longitude: longi)
            let propertyAnnotation = SchoolAnnotation(coordinate: propertyCoordinate, title: property.propertyAddress, subtitle: property.propertyDescription, property: property)
            mapView.addAnnotation(propertyAnnotation)
            mapView.setRegion(propertyAnnotation.region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let schoolAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView{
            schoolAnnotationView.animatesWhenAdded = true
            schoolAnnotationView.titleVisibility = .adaptive
            schoolAnnotationView.titleVisibility = .adaptive
            
            return schoolAnnotationView
        }
        else{
            return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        var prop = (view.annotation as! SchoolAnnotation).property
        selectedView = view
        self.performSegue(withIdentifier: "annSegue", sender: prop)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "annSegue") {
            let property = sender as! Property
            let vc = segue.destination as! PropertyDetailController
            vc.property = property
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
