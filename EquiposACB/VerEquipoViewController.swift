//
//  VerEquipoViewController.swift
//  EquiposACB
//
//  Created by CETYS on 24/02/18.
//  Copyright © 2018 JoaquinKike. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class VerEquipoViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet var miMapa: MKMapView!
    @IBOutlet var nombre: UILabel!
    @IBOutlet var ciudad: UILabel!
    @IBOutlet var estadio: UILabel!
    
    @IBAction func volver(_ sender: UIBarButtonItem) {
       
        
    }
    
    var nombreEquipo : String = ""
    var nombreCiudad : String = ""
    var nombreEstadio : String = ""
    var coordenadaX : NSDecimalNumber = 0
    var coordenadaY : NSDecimalNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print (nombreEquipo)
        nombre.text! = nombreEquipo
        ciudad.text! = nombreCiudad
        estadio.text! = nombreEstadio
        miMapa.delegate = self
        let coordenadasUFV =  CLLocationCoordinate2D(latitude: CLLocationDegrees(coordenadaX), longitude: CLLocationDegrees(coordenadaY))
        let miAnotacion = MKPointAnnotation()
        miAnotacion.coordinate = coordenadasUFV
        miAnotacion.title = nombreEstadio
        miAnotacion.subtitle = nombreEquipo
        
        miMapa.addAnnotation(miAnotacion)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        
        let reuseID = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseID) as? MKPinAnnotationView
        if pinView == nil{
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView?.pinTintColor = .purple
            
            
        }
        else{
            pinView!.annotation = annotation
        }
        return pinView
        
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
