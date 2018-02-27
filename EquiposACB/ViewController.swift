//
//  ViewController.swift
//  EquiposACB
//
//  Created by CETYS on 24/02/18.
//  Copyright © 2018 JoaquinKike. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet var nombre: UITextField!
    @IBOutlet var ciudad: UITextField!
    @IBOutlet var estadio: UITextField!
    @IBOutlet var latitud: UITextField!
    @IBOutlet var longitud: UITextField!
    
    
    @IBAction func cancelar(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func guardar(_ sender: UIBarButtonItem) {
        let _nombre = nombre.text!
        let _ciudad = ciudad.text!
        let _estadio = estadio.text!
        let _latitud = NSDecimalNumber(string:self.latitud.text!)
        let _longitud = NSDecimalNumber(string:self.longitud.text!)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entidad = NSEntityDescription.entity(forEntityName: "EquiposACB", in: managedContext)
        
        let registro = NSManagedObject(entity: entidad!, insertInto: managedContext)
        
        registro.setValue(_nombre, forKey: "nombre")
        registro.setValue(_ciudad, forKey: "ciudad")
        registro.setValue(_estadio, forKey: "estadio")
        registro.setValue(_latitud, forKey: "latitud")
        registro.setValue(_longitud, forKey: "longitud")
        
        do{
            try managedContext.save()
            print("equipo guardado ok")
        }   catch let error as NSError{
            print("No se ha podido escribir el equipo \(error), \(error.userInfo)")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

